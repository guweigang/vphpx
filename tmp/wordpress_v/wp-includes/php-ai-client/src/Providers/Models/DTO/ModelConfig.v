import rt

pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_modalities() string {
	return 'outputModalities'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_system_instruction() string {
	return 'systemInstruction'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_candidate_count() string {
	return 'candidateCount'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_max_tokens() string {
	return 'maxTokens'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_temperature() string {
	return 'temperature'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_top_p() string {
	return 'topP'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_top_k() string {
	return 'topK'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_stop_sequences() string {
	return 'stopSequences'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_presence_penalty() string {
	return 'presencePenalty'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_frequency_penalty() string {
	return 'frequencyPenalty'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_logprobs() string {
	return 'logprobs'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_top_logprobs() string {
	return 'topLogprobs'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_function_declarations() string {
	return 'functionDeclarations'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_web_search() string {
	return 'webSearch'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_file_type() string {
	return 'outputFileType'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_mime_type() string {
	return 'outputMimeType'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_schema() string {
	return 'outputSchema'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_media_orientation() string {
	return 'outputMediaOrientation'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_media_aspect_ratio() string {
	return 'outputMediaAspectRatio'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_speech_voice() string {
	return 'outputSpeechVoice'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_custom_options() string {
	return 'customOptions'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_input_modalities() string {
	return 'inputModalities'
}
struct Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig {
	rt.PhpObjectBase
pub mut:
		outputModalities rt.PhpVal = rt.new_null()
		systemInstruction rt.PhpVal = rt.new_null()
		candidateCount rt.PhpVal = rt.new_null()
		maxTokens rt.PhpVal = rt.new_null()
		temperature rt.PhpVal = rt.new_null()
		topP rt.PhpVal = rt.new_null()
		topK rt.PhpVal = rt.new_null()
		stopSequences rt.PhpVal = rt.new_null()
		presencePenalty rt.PhpVal = rt.new_null()
		frequencyPenalty rt.PhpVal = rt.new_null()
		logprobs rt.PhpVal = rt.new_null()
		topLogprobs rt.PhpVal = rt.new_null()
		functionDeclarations rt.PhpVal = rt.new_null()
		webSearch rt.PhpVal = rt.new_null()
		outputFileType rt.PhpVal = rt.new_null()
		outputMimeType rt.PhpVal = rt.new_null()
		outputSchema rt.PhpVal = rt.new_null()
		outputMediaOrientation rt.PhpVal = rt.new_null()
		outputMediaAspectRatio rt.PhpVal = rt.new_null()
		outputSpeechVoice rt.PhpVal = rt.new_null()
		customOptions rt.PhpVal = rt.new_array()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) magic_clone()  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_clonedDeclarations := rt.new_array()
		{
			mut iter_1 := this.functionDeclarations.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_declaration := item_1.val
				var_clonedDeclarations.array_push(// unsupported expression: Expr_Clone)
			}
		}
		this.functionDeclarations = var_clonedDeclarations.dup()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.webSearch = // unsupported expression: Expr_Clone
	}
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) setoutputmodalities(mut var_outputModalities Class_WordPress_AiClient_Providers_Models_DTO_array)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_is_list', [var_outputModalities]))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Output modalities must be a list array.'))))
	}
	this.outputModalities = var_outputModalities.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) getoutputmodalities() rt.PhpVal {
	return this.outputModalities
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) setsysteminstruction(systemInstruction string)  {
	this.systemInstruction = rt.new_string(systemInstruction).dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) getsysteminstruction() string {
	return (this.systemInstruction).str()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) setcandidatecount(candidateCount i64)  {
	this.candidateCount = rt.new_int(candidateCount).dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) getcandidatecount() i64 {
	return (this.candidateCount).to_i64()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) setmaxtokens(maxTokens i64)  {
	this.maxTokens = rt.new_int(maxTokens).dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) getmaxtokens() i64 {
	return (this.maxTokens).to_i64()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) settemperature(temperature f64)  {
	this.temperature = rt.new_float(temperature).dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) gettemperature() f64 {
	return (this.temperature).to_f64()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) settopp(topP f64)  {
	this.topP = rt.new_float(topP).dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) gettopp() f64 {
	return (this.topP).to_f64()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) settopk(topK i64)  {
	this.topK = rt.new_int(topK).dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) gettopk() i64 {
	return (this.topK).to_i64()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) setstopsequences(mut var_stopSequences Class_WordPress_AiClient_Providers_Models_DTO_array)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_is_list', [var_stopSequences]))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Stop sequences must be a list array.'))))
	}
	this.stopSequences = var_stopSequences.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) getstopsequences() rt.PhpVal {
	return this.stopSequences
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) setpresencepenalty(presencePenalty f64)  {
	this.presencePenalty = rt.new_float(presencePenalty).dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) getpresencepenalty() f64 {
	return (this.presencePenalty).to_f64()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) setfrequencypenalty(frequencyPenalty f64)  {
	this.frequencyPenalty = rt.new_float(frequencyPenalty).dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) getfrequencypenalty() f64 {
	return (this.frequencyPenalty).to_f64()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) setlogprobs(logprobs bool)  {
	this.logprobs = rt.new_bool(logprobs).dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) getlogprobs() bool {
	return (this.logprobs).to_bool()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) settoplogprobs(topLogprobs i64)  {
	this.topLogprobs = rt.new_int(topLogprobs).dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) gettoplogprobs() i64 {
	return (this.topLogprobs).to_i64()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) setfunctiondeclarations(mut var_functionDeclarations Class_WordPress_AiClient_Providers_Models_DTO_array)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_is_list', [var_functionDeclarations]))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Function declarations must be a list array.'))))
	}
	this.functionDeclarations = var_functionDeclarations.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) getfunctiondeclarations() rt.PhpVal {
	return this.functionDeclarations
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) setwebsearch(mut var_webSearch Class_WordPress_AiClient_Tools_DTO_WebSearch)  {
	this.webSearch = var_webSearch.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) getwebsearch() rt.PhpVal {
	return this.webSearch
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) setoutputfiletype(mut var_outputFileType Class_WordPress_AiClient_Files_Enums_FileTypeEnum)  {
	this.outputFileType = var_outputFileType.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) getoutputfiletype() rt.PhpVal {
	return this.outputFileType
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) setoutputmimetype(outputMimeType string)  {
	this.outputMimeType = rt.new_string(outputMimeType).dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) getoutputmimetype() string {
	return (this.outputMimeType).str()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) setoutputschema(mut var_outputSchema Class_WordPress_AiClient_Providers_Models_DTO_array)  {
	this.outputSchema = var_outputSchema.dup()
	if rt.is_true(rt.identical(this.outputMimeType, rt.new_null())) {
		this.outputMimeType = rt.new_string('application/json')
	}
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) getoutputschema() rt.PhpVal {
	return this.outputSchema
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) setoutputmediaorientation(mut var_outputMediaOrientation Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum)  {
	if rt.is_true(this.outputMediaAspectRatio) {
		this.validatemediaorientationaspectratiocompatibility(mut var_outputMediaOrientation, (this.outputMediaAspectRatio).str())
	}
	this.outputMediaOrientation = var_outputMediaOrientation.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) getoutputmediaorientation() rt.PhpVal {
	return this.outputMediaOrientation
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) setoutputmediaaspectratio(outputMediaAspectRatio string)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\d+:\\d+$/'), rt.new_string(outputMediaAspectRatio)]))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Output media aspect ratio must be in the format "width:height" (e.g. 3:2, 16:9).'))))
	}
	if rt.is_true(this.outputMediaOrientation) {
		this.validatemediaorientationaspectratiocompatibility(mut rt.cast_object_ptr[Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum](this.outputMediaOrientation), outputMediaAspectRatio)
	}
	this.outputMediaAspectRatio = rt.new_string(outputMediaAspectRatio).dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) getoutputmediaaspectratio() string {
	return (this.outputMediaAspectRatio).str()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) validatemediaorientationaspectratiocompatibility(mut var_orientation Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum, aspectRatio string)  {
	mut var_aspectRatioParts := rt.call_function('explode', [rt.new_string(':'), rt.new_string(aspectRatio)])
	if rt.is_true(rt.new_bool(rt.is_true(var_orientation.issquare()) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception('The aspect ratio "' + aspectRatio + '" is not compatible with the square orientation.')))
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_orientation.islandscape()) && rt.is_true(rt.less_equal(var_aspectRatioParts.array_get(0), var_aspectRatioParts.array_get(1))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception('The aspect ratio "' + aspectRatio + '" is not compatible with the landscape orientation.')))
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_orientation.isportrait()) && rt.is_true(rt.greater_equal(var_aspectRatioParts.array_get(0), var_aspectRatioParts.array_get(1))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception('The aspect ratio "' + aspectRatio + '" is not compatible with the portrait orientation.')))
	}
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) setoutputspeechvoice(outputSpeechVoice string)  {
	this.outputSpeechVoice = rt.new_string(outputSpeechVoice).dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) getoutputspeechvoice() string {
	return (this.outputSpeechVoice).str()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) setcustomoption(key string, var_value rt.PhpVal)  {
	this.customOptions.array_set(key, var_value.dup())
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) setcustomoptions(mut var_customOptions Class_WordPress_AiClient_Providers_Models_DTO_array)  {
	this.customOptions = var_customOptions.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) getcustomoptions() rt.PhpVal {
	return this.customOptions
}

fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.getjsonschema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_modalities(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Messages_Enums_ModalityEnum{}; return temp.getvalues() }() }]) }, rt.ArrayItem{ key: 'description', val: 'Output modalities for the model.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_system_instruction(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'System instruction for the model.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_candidate_count(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'minimum', val: 1 }, rt.ArrayItem{ key: 'description', val: 'Number of response candidates to generate.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_max_tokens(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'minimum', val: 1 }, rt.ArrayItem{ key: 'description', val: 'Maximum number of tokens to generate.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_temperature(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'minimum', val: 0 }, rt.ArrayItem{ key: 'maximum', val: 2 }, rt.ArrayItem{ key: 'description', val: 'Temperature for randomness.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_top_p(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'minimum', val: 0 }, rt.ArrayItem{ key: 'maximum', val: 1 }, rt.ArrayItem{ key: 'description', val: 'Top-p nucleus sampling parameter.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_top_k(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'minimum', val: 1 }, rt.ArrayItem{ key: 'description', val: 'Top-k sampling parameter.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_stop_sequences(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'description', val: 'Stop sequences.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_presence_penalty(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'description', val: 'Presence penalty for reducing repetition.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_frequency_penalty(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'description', val: 'Frequency penalty for reducing repetition.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_logprobs(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: 'Whether to return log probabilities.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_top_logprobs(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'minimum', val: 1 }, rt.ArrayItem{ key: 'description', val: 'Number of top log probabilities to return.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_function_declarations(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration{}; return temp.getjsonschema() }() }, rt.ArrayItem{ key: 'description', val: 'Function declarations available to the model.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_web_search(), val: fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Tools_DTO_WebSearch{}; return temp.getjsonschema() }() }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_file_type(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Files_Enums_FileTypeEnum{}; return temp.getvalues() }() }, rt.ArrayItem{ key: 'description', val: 'Output file type.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_mime_type(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'Output MIME type.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_schema(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'additionalProperties', val: true }, rt.ArrayItem{ key: 'description', val: 'Output schema (JSON schema).' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_media_orientation(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum{}; return temp.getvalues() }() }, rt.ArrayItem{ key: 'description', val: 'Output media orientation.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_media_aspect_ratio(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: '^\\d+:\\d+$' }, rt.ArrayItem{ key: 'description', val: 'Output media aspect ratio.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_speech_voice(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'Output speech voice.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_custom_options(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'additionalProperties', val: true }, rt.ArrayItem{ key: 'description', val: 'Custom provider-specific options.' }]) }]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }])
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) toarray() rt.PhpVal {
	mut var_data := rt.new_array()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_modality := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_modality, 'value')
	}
	mut var_modality := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_modality, 'value')
	}
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_modalities(), rt.call_function('array_map', [rt.new_closure(closure_1_fn), this.outputModalities]))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_system_instruction(), this.systemInstruction)
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_candidate_count(), this.candidateCount)
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_max_tokens(), this.maxTokens)
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_temperature(), this.temperature)
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_top_p(), this.topP)
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_top_k(), this.topK)
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_stop_sequences(), this.stopSequences)
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_presence_penalty(), this.presencePenalty)
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_frequency_penalty(), this.frequencyPenalty)
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_logprobs(), this.logprobs)
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_top_logprobs(), this.topLogprobs)
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_functionDeclaration := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_functionDeclaration, 'toArray', []rt.PhpVal{})
	}
	mut var_functionDeclaration := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_functionDeclaration, 'toArray', []rt.PhpVal{})
	}
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_function_declarations(), rt.call_function('array_map', [rt.new_closure(closure_3_fn), this.functionDeclarations]))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_web_search(), rt.call_method(this.webSearch, 'toArray', []rt.PhpVal{}))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_file_type(), rt.get_property(this.outputFileType, 'value'))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_mime_type(), this.outputMimeType)
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_schema(), this.outputSchema)
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_media_orientation(), rt.get_property(this.outputMediaOrientation, 'value'))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_media_aspect_ratio(), this.outputMediaAspectRatio)
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_output_speech_voice(), this.outputSpeechVoice)
	}
	if !(!rt.is_true(this.customOptions)) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_custom_options(), this.customOptions)
	}
	return var_data.dup()
}

fn Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.fromarray(mut var_array Class_WordPress_AiClient_Providers_Models_DTO_array) rt.PhpVal {
	mut var_modality := rt.new_null()
	mut var_config := 
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	return mut 
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_Enums_ModalityEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Tools_DTO_WebSearch {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Files_Enums_FileTypeEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_models_dto_modelconfig() &Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig{
		PhpObjectBase: rt.PhpObjectBase{}
		outputModalities: rt.new_null()
		systemInstruction: rt.new_null()
		candidateCount: rt.new_null()
		maxTokens: rt.new_null()
		temperature: rt.new_null()
		topP: rt.new_null()
		topK: rt.new_null()
		stopSequences: rt.new_null()
		presencePenalty: rt.new_null()
		frequencyPenalty: rt.new_null()
		logprobs: rt.new_null()
		topLogprobs: rt.new_null()
		functionDeclarations: rt.new_null()
		webSearch: rt.new_null()
		outputFileType: rt.new_null()
		outputMimeType: rt.new_null()
		outputSchema: rt.new_null()
		outputMediaOrientation: rt.new_null()
		outputMediaAspectRatio: rt.new_null()
		outputSpeechVoice: rt.new_null()
		customOptions: rt.new_array()
	}
	return obj
}

fn create_wordpress_aiclient_common_abstractdatatransferobject() &Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	mut obj := &Class_WordPress_AiClient_Common_AbstractDataTransferObject{
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

fn create_wordpress_aiclient_messages_enums_modalityenum() &Class_WordPress_AiClient_Messages_Enums_ModalityEnum {
	mut obj := &Class_WordPress_AiClient_Messages_Enums_ModalityEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_tools_dto_functiondeclaration() &Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration {
	mut obj := &Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_tools_dto_websearch() &Class_WordPress_AiClient_Tools_DTO_WebSearch {
	mut obj := &Class_WordPress_AiClient_Tools_DTO_WebSearch{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_files_enums_filetypeenum() &Class_WordPress_AiClient_Files_Enums_FileTypeEnum {
	mut obj := &Class_WordPress_AiClient_Files_Enums_FileTypeEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_files_enums_mediaorientationenum() &Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum {
	mut obj := &Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		'setOutputModalities' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setoutputmodalities(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getOutputModalities' {
			return this.getoutputmodalities()
		}
		'setSystemInstruction' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.setsysteminstruction(dispatch_arg_0)
			return rt.new_null()
		}
		'getSystemInstruction' {
			return rt.new_string(this.getsysteminstruction())
		}
		'setCandidateCount' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.setcandidatecount(dispatch_arg_0)
			return rt.new_null()
		}
		'getCandidateCount' {
			return rt.new_int(this.getcandidatecount())
		}
		'setMaxTokens' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.setmaxtokens(dispatch_arg_0)
			return rt.new_null()
		}
		'getMaxTokens' {
			return rt.new_int(this.getmaxtokens())
		}
		'setTemperature' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_f64()
			this.settemperature(dispatch_arg_0)
			return rt.new_null()
		}
		'getTemperature' {
			return rt.new_float(this.gettemperature())
		}
		'setTopP' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_f64()
			this.settopp(dispatch_arg_0)
			return rt.new_null()
		}
		'getTopP' {
			return rt.new_float(this.gettopp())
		}
		'setTopK' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.settopk(dispatch_arg_0)
			return rt.new_null()
		}
		'getTopK' {
			return rt.new_int(this.gettopk())
		}
		'setStopSequences' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setstopsequences(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getStopSequences' {
			return this.getstopsequences()
		}
		'setPresencePenalty' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_f64()
			this.setpresencepenalty(dispatch_arg_0)
			return rt.new_null()
		}
		'getPresencePenalty' {
			return rt.new_float(this.getpresencepenalty())
		}
		'setFrequencyPenalty' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_f64()
			this.setfrequencypenalty(dispatch_arg_0)
			return rt.new_null()
		}
		'getFrequencyPenalty' {
			return rt.new_float(this.getfrequencypenalty())
		}
		'setLogprobs' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.setlogprobs(dispatch_arg_0)
			return rt.new_null()
		}
		'getLogprobs' {
			return rt.new_bool(this.getlogprobs())
		}
		'setTopLogprobs' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.settoplogprobs(dispatch_arg_0)
			return rt.new_null()
		}
		'getTopLogprobs' {
			return rt.new_int(this.gettoplogprobs())
		}
		'setFunctionDeclarations' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setfunctiondeclarations(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getFunctionDeclarations' {
			return this.getfunctiondeclarations()
		}
		'setWebSearch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_WebSearch](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setwebsearch(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getWebSearch' {
			return this.getwebsearch()
		}
		'setOutputFileType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Files_Enums_FileTypeEnum](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setoutputfiletype(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getOutputFileType' {
			return this.getoutputfiletype()
		}
		'setOutputMimeType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.setoutputmimetype(dispatch_arg_0)
			return rt.new_null()
		}
		'getOutputMimeType' {
			return rt.new_string(this.getoutputmimetype())
		}
		'setOutputSchema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setoutputschema(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getOutputSchema' {
			return this.getoutputschema()
		}
		'setOutputMediaOrientation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setoutputmediaorientation(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getOutputMediaOrientation' {
			return this.getoutputmediaorientation()
		}
		'setOutputMediaAspectRatio' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.setoutputmediaaspectratio(dispatch_arg_0)
			return rt.new_null()
		}
		'getOutputMediaAspectRatio' {
			return rt.new_string(this.getoutputmediaaspectratio())
		}
		'validateMediaOrientationAspectRatioCompatibility' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.validatemediaorientationaspectratiocompatibility(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'setOutputSpeechVoice' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.setoutputspeechvoice(dispatch_arg_0)
			return rt.new_null()
		}
		'getOutputSpeechVoice' {
			return rt.new_string(this.getoutputspeechvoice())
		}
		'setCustomOption' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.setcustomoption(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'setCustomOptions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setcustomoptions(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getCustomOptions' {
			return this.getcustomoptions()
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.fromarray(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'outputModalities' { return this.outputModalities }
		'systemInstruction' { return this.systemInstruction }
		'candidateCount' { return this.candidateCount }
		'maxTokens' { return this.maxTokens }
		'temperature' { return this.temperature }
		'topP' { return this.topP }
		'topK' { return this.topK }
		'stopSequences' { return this.stopSequences }
		'presencePenalty' { return this.presencePenalty }
		'frequencyPenalty' { return this.frequencyPenalty }
		'logprobs' { return this.logprobs }
		'topLogprobs' { return this.topLogprobs }
		'functionDeclarations' { return this.functionDeclarations }
		'webSearch' { return this.webSearch }
		'outputFileType' { return this.outputFileType }
		'outputMimeType' { return this.outputMimeType }
		'outputSchema' { return this.outputSchema }
		'outputMediaOrientation' { return this.outputMediaOrientation }
		'outputMediaAspectRatio' { return this.outputMediaAspectRatio }
		'outputSpeechVoice' { return this.outputSpeechVoice }
		'customOptions' { return this.customOptions }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'outputModalities' { this.outputModalities = val; return true }
		'systemInstruction' { this.systemInstruction = val; return true }
		'candidateCount' { this.candidateCount = val; return true }
		'maxTokens' { this.maxTokens = val; return true }
		'temperature' { this.temperature = val; return true }
		'topP' { this.topP = val; return true }
		'topK' { this.topK = val; return true }
		'stopSequences' { this.stopSequences = val; return true }
		'presencePenalty' { this.presencePenalty = val; return true }
		'frequencyPenalty' { this.frequencyPenalty = val; return true }
		'logprobs' { this.logprobs = val; return true }
		'topLogprobs' { this.topLogprobs = val; return true }
		'functionDeclarations' { this.functionDeclarations = val; return true }
		'webSearch' { this.webSearch = val; return true }
		'outputFileType' { this.outputFileType = val; return true }
		'outputMimeType' { this.outputMimeType = val; return true }
		'outputSchema' { this.outputSchema = val; return true }
		'outputMediaOrientation' { this.outputMediaOrientation = val; return true }
		'outputMediaAspectRatio' { this.outputMediaAspectRatio = val; return true }
		'outputSpeechVoice' { this.outputSpeechVoice = val; return true }
		'customOptions' { this.customOptions = val; return true }
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


fn (mut this Class_WordPress_AiClient_Common_Exception_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_Exception_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Tools_DTO_WebSearch) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Tools_DTO_WebSearch) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_WebSearch) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Files_Enums_FileTypeEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Files_Enums_FileTypeEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Files_Enums_FileTypeEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_php_ai_client_src_providers_models_dto_modelconfig_php() {
	// unsupported statement: Stmt_Declare
}
