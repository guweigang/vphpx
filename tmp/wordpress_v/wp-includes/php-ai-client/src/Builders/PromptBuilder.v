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

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) construct(mut var_registry Class_WordPress_AiClient_Providers_ProviderRegistry, var_prompt rt.PhpVal, mut var_eventDispatcher Class_WordPress_AiClient_Builders_?EventDispatcherInterface)  {
	this.registry = var_registry.dup()
	this.modelConfig = create_wordpress_aiclient_providers_models_dto_modelconfig()
	this.eventDispatcher = var_eventDispatcher.dup()
	if rt.is_true(rt.identical(var_prompt, rt.new_null())) {
		return
	}
	if this.ismessageslist(var_prompt.dup()) {
		this.messages = var_prompt.dup()
		return
	}
	mut var_userMessage := this.parsemessage(var_prompt.dup(), mut rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum](fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum{}; return temp.user() }()))
	this.messages.array_push(var_userMessage.dup())
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) magic_clone()  {
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
	this.modelConfig = // unsupported expression: Expr_Clone
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.requestOptions = // unsupported expression: Expr_Clone
	}
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) withtext(text string) rt.PhpVal {
	mut var_part := create_wordpress_aiclient_messages_dto_messagepart(rt.new_string(text).dup())
	this.appendparttomessages(mut var_part)
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) withfile(var_file rt.PhpVal, mut var_mimeType Class_WordPress_AiClient_Builders_?string) rt.PhpVal {
	mut var_file_mutated := var_file
	var_file_mutated = if rt.is_true(rt.new_bool(rt.instance_of(var_file_mutated, 'WordPress_AiClient_Files_DTO_File'))) { var_file_mutated } else { create_wordpress_aiclient_files_dto_file(var_file_mutated.dup(), var_mimeType.dup()) }
	mut var_part := create_wordpress_aiclient_messages_dto_messagepart(var_file_mutated.dup())
	this.appendparttomessages(mut var_part)
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) withfunctionresponse(mut var_functionResponse Class_WordPress_AiClient_Tools_DTO_FunctionResponse) rt.PhpVal {
	mut var_part := create_wordpress_aiclient_messages_dto_messagepart(var_functionResponse.dup())
	this.appendparttomessages(mut var_part)
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) withmessageparts(mut var_parts Class_WordPress_AiClient_Messages_DTO_MessagePart) rt.PhpVal {
	mut var_parts_mutated := var_parts
	{
		mut iter_1 := var_parts_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_part := item_1.val
			this.appendparttomessages(mut rt.cast_object_ptr[Class_WordPress_AiClient_Messages_DTO_MessagePart](var_part))
		}
	}
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) withhistory(mut var_messages Class_WordPress_AiClient_Messages_DTO_Message) rt.PhpVal {
	this.messages = rt.call_function('array_merge', [var_messages, this.messages])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingmodel(mut var_model Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface) rt.PhpVal {
	mut var_model_mutated := var_model
	this.model = var_model_mutated.dup()
	mut var_modelConfigArray := rt.call_method(rt.call_method(var_model_mutated, 'getConfig', []rt.PhpVal{}), 'toArray', []rt.PhpVal{})
	mut var_builderConfigArray := rt.call_method(this.modelConfig, 'toArray', []rt.PhpVal{})
	mut var_mergedConfigArray := rt.call_function('array_merge', [var_modelConfigArray.dup(), var_builderConfigArray.dup()])
	this.modelConfig = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig{}; return temp.fromarray(arg_0) }(var_mergedConfigArray.dup())
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingmodelpreference(var_preferredModels rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(var_preferredModels, rt.new_array())) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('At least one model preference must be provided.'))))
	}
	mut var_preferenceKeys := rt.new_array()
	{
		mut iter_1 := var_preferredModels.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_preferredModel := item_1.val
			if rt.is_true(rt.new_bool(var_preferredModel.dup().is_array())) {
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_is_list', [var_preferredModel.dup()]))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Model preference tuple must contain model identifier and provider ID.'))))
				}
				// unsupported assign target: Expr_List
				mut var_modelId := rt.new_string(this.normalizepreferenceidentifier(var_modelId.dup(), ''))
				mut var_providerId := rt.new_string(this.normalizepreferenceidentifier(var_providerId.dup(), 'Model preference provider identifiers cannot be empty.'))
				mut var_preferenceKey := rt.new_string(this.createprovidermodelpreferencekey((var_providerId).str(), (var_modelId).str()))
			} else if rt.is_true(rt.new_bool(rt.instance_of(var_preferredModel, 'WordPress_AiClient_Providers_Models_Contracts_ModelInterface'))) {
				var_modelId = rt.call_method(rt.call_method(var_preferredModel, 'metadata', []rt.PhpVal{}), 'getId', []rt.PhpVal{})
				var_providerId = rt.call_method(rt.call_method(var_preferredModel, 'providerMetadata', []rt.PhpVal{}), 'getId', []rt.PhpVal{})
				var_preferenceKey = rt.new_string(this.createprovidermodelpreferencekey((var_providerId).str(), (var_modelId).str()))
			} else if rt.is_true(rt.new_bool(var_preferredModel.dup().is_string())) {
				var_modelId = rt.new_string(this.normalizepreferenceidentifier(var_preferredModel.dup(), ''))
				var_preferenceKey = rt.new_string(this.createmodelpreferencekey((var_modelId).str()))
			} else {
				rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception('Model preferences must be model identifiers, instances of ModelInterface, ' + 'or provider/model tuples.')))
			}
			var_preferenceKeys.array_push(var_preferenceKey.dup())
		}
	}
	this.modelPreferenceKeys = var_preferenceKeys.dup()
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingmodelconfig(mut var_config Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) rt.PhpVal {
	mut var_builderConfigArray := rt.call_method(this.modelConfig, 'toArray', []rt.PhpVal{})
	mut var_providedConfigArray := var_config.toarray()
	mut var_mergedArray := rt.call_function('array_merge', [var_providedConfigArray.dup(), var_builderConfigArray.dup()])
	this.modelConfig = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig{}; return temp.fromarray(arg_0) }(var_mergedArray.dup())
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingprovider(providerIdOrClassName string) rt.PhpVal {
	this.providerIdOrClassName = rt.new_string(providerIdOrClassName).dup()
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
	
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingtopk(topK i64) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingstopsequences(stopSequences string) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingcandidatecount(candidateCount i64) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingfunctiondeclarations(mut var_functionDeclarations Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingpresencepenalty(presencePenalty f64) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingfrequencypenalty(frequencyPenalty f64) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingwebsearch(mut var_webSearch Class_WordPress_AiClient_Tools_DTO_WebSearch) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingrequestoptions(mut var_requestOptions Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingtoplogprobs(mut var_topLogprobs Class_WordPress_AiClient_Builders_?int) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) asoutputmimetype(mimeType string) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) asoutputschema(mut var_schema Class_WordPress_AiClient_Builders_array) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) asoutputmodalities(mut var_modalities Class_WordPress_AiClient_Messages_Enums_ModalityEnum) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) asoutputfiletype(mut var_fileType Class_WordPress_AiClient_Files_Enums_FileTypeEnum) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) asoutputmediaorientation(mut var_orientation Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) asoutputmediaaspectratio(aspectRatio string) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) asoutputspeechvoice(voice string) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) asjsonresponse(mut var_schema Class_WordPress_AiClient_Builders_?array) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) infercapabilityfromoutputmodalities() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) infercapabilityfrommodelinterfaces(mut var_model Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface) rt.PhpVal {
	mut var_model_mutated := var_model
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) issupported(mut var_capability Class_WordPress_AiClient_Builders_?CapabilityEnum) bool {
	mut var_capability_mutated := var_capability
	return false
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) issupportedfortextgeneration() bool {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) issupportedforimagegeneration() bool {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) issupportedfortexttospeechconversion() bool {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) issupportedforvideogeneration() bool {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) issupportedforspeechgeneration() bool {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) issupportedformusicgeneration() bool {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) issupportedforembeddinggeneration() bool {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generateresult(mut var_capability Class_WordPress_AiClient_Builders_?CapabilityEnum) rt.PhpVal {
	mut var_capability_mutated := var_capability
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) executemodelgeneration(mut var_model Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface, mut var_capability Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum, mut var_messages Class_WordPress_AiClient_Builders_array) rt.PhpVal {
	mut var_model_mutated := var_model
	mut var_capability_mutated := var_capability
	return rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatetextresult() rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generateimageresult() rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatespeechresult() rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) converttexttospeechresult() rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatevideoresult() rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatetext() string {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatetexts(mut var_candidateCount Class_WordPress_AiClient_Builders_?int) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generateimage() rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generateimages(mut var_candidateCount Class_WordPress_AiClient_Builders_?int) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) converttexttospeech() rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) converttexttospeeches(mut var_candidateCount Class_WordPress_AiClient_Builders_?int) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatespeech() rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatespeeches(mut var_candidateCount Class_WordPress_AiClient_Builders_?int) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatevideo() rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatevideos(mut var_candidateCount Class_WordPress_AiClient_Builders_?int) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) appendparttomessages(mut var_part Class_WordPress_AiClient_Messages_DTO_MessagePart)  {
	mut var_part_mutated := var_part
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) getconfiguredmodel(mut var_capability Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum) rt.PhpVal {
	mut var_providerId := rt.new_null()
	mut var_modelId := rt.new_null()
	mut var_capability_mutated := var_capability
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) bindmodelrequestoptions(mut var_model Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface)  {
	mut var_model_mutated := var_model
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) getcandidatemodelsmap(mut var_requirements Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) rt.PhpVal {
	mut var_requirements_mutated := var_requirements
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatemapfromcandidates(providerId string, mut var_modelsMetadata Class_WordPress_AiClient_Builders_array) rt.PhpVal {
	mut providerId_mutated := providerId
	mut var_modelsMetadata_mutated := var_modelsMetadata
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) normalizepreferenceidentifier(var_value rt.PhpVal, emptyMessage string) string {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) createprovidermodelpreferencekey(providerId string, modelId string) string {
	mut providerId_mutated := providerId
	mut modelId_mutated := modelId
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) createmodelpreferencekey(modelId string) string {
	mut modelId_mutated := modelId
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) parsemessage(var_input rt.PhpVal, mut var_defaultRole Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) validatemessages()  {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) ismessageslist(var_value rt.PhpVal) bool {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) includeoutputmodalities(mut var_modalities Class_WordPress_AiClient_Messages_Enums_ModalityEnum)  {
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) dispatchevent(mut var_event Class_WordPress_AiClient_Builders_object)  {
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

fn create_wordpress_aiclient_providers_models_dto_modelconfig() &Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig{
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

fn create_wordpress_aiclient_files_dto_file() &Class_WordPress_AiClient_Files_DTO_File {
	mut obj := &Class_WordPress_AiClient_Files_DTO_File{
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




pub fn init_wp_includes_php_ai_client_src_builders_promptbuilder_php() {
	// unsupported statement: Stmt_Declare
}
