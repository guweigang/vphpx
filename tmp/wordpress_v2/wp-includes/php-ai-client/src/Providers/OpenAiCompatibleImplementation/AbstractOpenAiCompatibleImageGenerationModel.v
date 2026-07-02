import rt

struct Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleImageGenerationModel {
	rt.PhpObjectBase
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleImageGenerationModel) generateimageresult(mut var_prompt Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array) rt.PhpVal {
	mut var_httpTransporter := this.gethttptransporter()
	mut var_params := this.preparegenerateimageparams(mut var_prompt)
	mut iife_temp_0 := Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum{}
	mut iife_result_0 := iife_temp_0.post()
	mut var_request := this.createrequest(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum](iife_result_0), 'images/generations', mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](rt.create_array([rt.ArrayItem{ key: 'Content-Type', val: 'application/json' }])), var_params.clone())
	var_request = rt.call_method(this.getrequestauthentication(), 'authenticateRequest', [var_request.clone()])
	mut var_response := rt.call_method(var_httpTransporter, 'send', [var_request.clone()])
	this.throwifnotsuccessful(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_Response](var_response))
	return this.parseresponsetogenerativeairesult(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_Response](var_response), if var_params.array_isset(rt.new_string('output_format')) && var_params.array_get(rt.new_string('output_format')).is_string() { rt.concat(rt.new_string('image/'), var_params.array_get(rt.new_string('output_format'))) } else { 'image/png' })
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleImageGenerationModel) preparegenerateimageparams(mut var_prompt Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array) rt.PhpVal {
	mut var_config := this.getconfig()
	mut var_params := rt.create_array([rt.ArrayItem{ key: 'model', val: rt.call_method(this.metadata(), 'getId', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'prompt', val: this.preparepromptparam(mut var_prompt) }])
	mut var_candidateCount := rt.call_method(var_config, 'getCandidateCount', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_candidateCount, rt.new_null())))) {
		var_params.array_set('n', var_candidateCount.clone())
	}
	mut var_outputFileType := rt.call_method(var_config, 'getOutputFileType', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_outputFileType, rt.new_null())))) {
		var_params.array_set('response_format', if rt.is_true(rt.call_method(var_outputFileType, 'isRemote', []rt.PhpVal{})) { 'url' } else { 'b64_json' })
	} else {
		var_params.array_set('response_format', 'b64_json')
	}
	mut var_outputMimeType := rt.call_method(var_config, 'getOutputMimeType', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_outputMimeType, rt.new_null())))) {
		var_params.array_set('output_format', rt.call_function('preg_replace', [rt.new_string('/^image\\//'), rt.new_string(''), var_outputMimeType.clone()]))
	}
	mut var_outputMediaOrientation := rt.call_method(var_config, 'getOutputMediaOrientation', []rt.PhpVal{})
	mut var_outputMediaAspectRatio := rt.call_method(var_config, 'getOutputMediaAspectRatio', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_outputMediaOrientation, rt.new_null())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_outputMediaAspectRatio, rt.new_null())))) {
		var_params.array_set('size', this.preparesizeparam(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_?MediaOrientationEnum](var_outputMediaOrientation), mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_?string](var_outputMediaAspectRatio)))
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

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleImageGenerationModel) preparepromptparam(mut var_messages Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array) string {
	if rt.is_true(rt.new_bool(var_messages.array_count() != 1)) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('The API requires a single user message as prompt.'))))
	}
	mut var_message := var_messages.array_get(rt.new_int(0))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(var_message, 'getRole', []rt.PhpVal{}), 'isUser', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('The API requires a user message as prompt.'))))
	}
	mut var_text := rt.new_null()
	mut iter_2 := rt.call_method(var_message, 'getParts', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_part := item_2.val
		var_text = rt.call_method(var_part, 'getText', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_text, rt.new_null())))) {
			break
		}
	}
	if rt.is_true(rt.identical(var_text, rt.new_null())) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('The API requires a single text message part as prompt.'))))
	}
	return (var_text).str()
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleImageGenerationModel) preparesizeparam(mut var_orientation Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_?MediaOrientationEnum, mut var_aspectRatio Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_?string) string {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_aspectRatio, rt.new_null())))) {
		mut switch_val_1 := var_aspectRatio
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('1:1'))) {
			return '1024x1024'
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('3:2'))) {
			return '1536x1024'
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('7:4'))) {
			return '1792x1024'
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('2:3'))) {
			return '1024x1536'
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('4:7'))) {
			return '1024x1792'
		} else {
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception('The aspect ratio "' + (var_aspectRatio).str() + '" is not supported.')))
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_orientation, rt.new_null())))) {
		if rt.is_true(var_orientation.islandscape()) {
			return '1536x1024'
		}
		if rt.is_true(var_orientation.isportrait()) {
			return '1024x1536'
		}
	}
	return '1024x1024'
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleImageGenerationModel) createrequest(mut var_method Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum, path string, mut var_headers Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array, var_data rt.PhpVal) {
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleImageGenerationModel) throwifnotsuccessful(mut var_response Class_WordPress_AiClient_Providers_Http_DTO_Response) {
	mut var_response_mutated := var_response
mut iife_temp_1 := Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil{}
mut iife_result_1 := iife_temp_1.throwifnotsuccessful(rt.new_object('WordPress_AiClient_Providers_Http_DTO_Response', []string{}, var_response_mutated))
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleImageGenerationModel) parseresponsetogenerativeairesult(mut var_response Class_WordPress_AiClient_Providers_Http_DTO_Response, expectedMimeType string) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_responseData := rt.call_method(var_response_mutated, 'getData', []rt.PhpVal{})
	if !(var_responseData.array_isset(rt.new_string('data'))) || rt.is_true(rt.new_bool(!(rt.is_true(var_responseData.array_get(rt.new_string('data')))))) {
		mut iife_temp_2 := Class_WordPress_AiClient_Providers_Http_Exception_ResponseException{}
		mut iife_result_2 := iife_temp_2.frommissingdata(rt.call_method(this.providermetadata(), 'getName', []rt.PhpVal{}), rt.new_string('data'))
		rt.throw_exception(iife_result_2)
	}
	if !(var_responseData.array_get(rt.new_string('data')).is_array()) {
		mut iife_temp_3 := Class_WordPress_AiClient_Providers_Http_Exception_ResponseException{}
		mut iife_result_3 := iife_temp_3.frominvaliddata(rt.call_method(this.providermetadata(), 'getName', []rt.PhpVal{}), rt.new_string('data'), rt.new_string('The value must be an array.'))
		rt.throw_exception(iife_result_3)
	}
	mut var_candidates := rt.new_array()
	mut iter_3 := var_responseData.array_get(rt.new_string('data')).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_choiceData := item_3.val
		mut var_index := item_3.key
		if !(var_choiceData.clone().is_array()) || rt.is_true(rt.call_function('array_is_list', [var_choiceData.clone()])) {
			mut iife_temp_4 := Class_WordPress_AiClient_Providers_Http_Exception_ResponseException{}
			mut iife_result_4 := iife_temp_4.frominvaliddata(rt.call_method(this.providermetadata(), 'getName', []rt.PhpVal{}), rt.new_string("data[${var_index.to_string()}]"), rt.new_string('The value must be an associative array.'))
			rt.throw_exception(iife_result_4)
		}
		var_candidates.array_push(this.parseresponsechoicetocandidate(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](var_choiceData), (var_index).to_i64(), expectedMimeType))
	}
	mut var_id := rt.new_string(this.getresultid(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](var_responseData)))
	if var_responseData.array_isset(rt.new_string('usage')) && var_responseData.array_get(rt.new_string('usage')).is_array() {
	mut var_usage := var_responseData.array_get(rt.new_string('usage'))
	mut var_tokenUsage := create_wordpress_aiclient_results_dto_tokenusage(if !(var_usage.array_get(rt.new_string('input_tokens'))).is_null() { var_usage.array_get(rt.new_string('input_tokens')) } else { rt.new_int(0) }, if !(var_usage.array_get(rt.new_string('output_tokens'))).is_null() { var_usage.array_get(rt.new_string('output_tokens')) } else { rt.new_int(0) }, if !(var_usage.array_get(rt.new_string('total_tokens'))).is_null() { var_usage.array_get(rt.new_string('total_tokens')) } else { rt.new_int(0) })
	} else {
	var_tokenUsage = create_wordpress_aiclient_results_dto_tokenusage(rt.new_int(0), rt.new_int(0), rt.new_int(0))
	}
	mut var_providerMetadata := var_responseData.clone()
	var_providerMetadata.array_unset(rt.new_string('id'))
	var_providerMetadata.array_unset(rt.new_string('data'))
	var_providerMetadata.array_unset(rt.new_string('usage'))
	return rt.new_object('WordPress_AiClient_Results_DTO_GenerativeAiResult', []string{}, create_wordpress_aiclient_results_dto_generativeairesult(var_id.clone(), var_candidates.clone(), var_tokenUsage, this.providermetadata(), this.metadata(), var_providerMetadata.clone()))
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleImageGenerationModel) parseresponsechoicetocandidate(mut var_choiceData Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array, index i64, expectedMimeType string) rt.PhpVal {
	if var_choiceData.array_isset(rt.new_string('url')) && var_choiceData.array_get(rt.new_string('url')).is_string() {
	mut var_imageFile := create_wordpress_aiclient_files_dto_file(var_choiceData.array_get(rt.new_string('url')), rt.new_string(expectedMimeType))
	} else if var_choiceData.array_isset(rt.new_string('b64_json')) && var_choiceData.array_get(rt.new_string('b64_json')).is_string() {
	var_imageFile = create_wordpress_aiclient_files_dto_file(var_choiceData.array_get(rt.new_string('b64_json')), rt.new_string(expectedMimeType))
	} else {
		mut iife_temp_5 := Class_WordPress_AiClient_Providers_Http_Exception_ResponseException{}
		mut iife_result_5 := iife_temp_5.frominvaliddata(rt.call_method(this.providermetadata(), 'getName', []rt.PhpVal{}), rt.new_string("choices[${var_index.str()}]"), rt.new_string('The value must contain either a url or b64_json key with a string value.'))
		rt.throw_exception(iife_result_5)
	}
	mut var_parts := rt.create_array([rt.ArrayItem{ key: none, val: create_wordpress_aiclient_messages_dto_messagepart(var_imageFile) }])
	mut iife_temp_6 := Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum{}
	mut iife_result_6 := iife_temp_6.model()
	mut var_message := create_wordpress_aiclient_messages_dto_message(iife_result_6, var_parts.clone())
	mut iife_temp_7 := Class_WordPress_AiClient_Results_Enums_FinishReasonEnum{}
	mut iife_result_7 := iife_temp_7.stop()
	return rt.new_object('WordPress_AiClient_Results_DTO_Candidate', []string{}, create_wordpress_aiclient_results_dto_candidate(var_message.clone(), iife_result_7))
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleImageGenerationModel) getresultid(mut var_responseData Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array) string {
	mut var_responseData_mutated := var_responseData
	return (if var_responseData_mutated.array_isset(rt.new_string('id')) && var_responseData_mutated.array_get(rt.new_string('id')).is_string() { var_responseData_mutated.array_get(rt.new_string('id')) } else { rt.new_string('') }).str()
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

struct Class_WordPress_AiClient_Files_DTO_File {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_DTO_MessagePart {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_DTO_Message {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Results_DTO_Candidate {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Results_Enums_FinishReasonEnum {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_openaicompatibleimplementation_abstractopenaicompatibleimagegenerationmodel(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleImageGenerationModel {
	mut obj := &Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleImageGenerationModel{
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

fn create_wordpress_aiclient_files_dto_file(_args ...rt.PhpVal) &Class_WordPress_AiClient_Files_DTO_File {
	mut obj := &Class_WordPress_AiClient_Files_DTO_File{
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

fn create_wordpress_aiclient_messages_dto_message(_args ...rt.PhpVal) &Class_WordPress_AiClient_Messages_DTO_Message {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_Message{
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

fn create_wordpress_aiclient_results_dto_candidate(_args ...rt.PhpVal) &Class_WordPress_AiClient_Results_DTO_Candidate {
	mut obj := &Class_WordPress_AiClient_Results_DTO_Candidate{
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

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleImageGenerationModel) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'generateImageResult' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.generateimageresult(mut dispatch_arg_0)
		}
		'prepareGenerateImageParams' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.preparegenerateimageparams(mut dispatch_arg_0)
		}
		'preparePromptParam' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.preparepromptparam(mut dispatch_arg_0))
		}
		'prepareSizeParam' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_?MediaOrientationEnum](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.preparesizeparam(mut dispatch_arg_0, mut dispatch_arg_1))
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
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.parseresponsetogenerativeairesult(mut dispatch_arg_0, dispatch_arg_1)
		}
		'parseResponseChoiceToCandidate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.parseresponsechoicetocandidate(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'getResultId' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.getresultid(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleImageGenerationModel) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleImageGenerationModel) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WordPress_AiClient_Files_DTO_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Files_DTO_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WordPress_AiClient_Results_DTO_Candidate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Results_DTO_Candidate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Results_DTO_Candidate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

}
