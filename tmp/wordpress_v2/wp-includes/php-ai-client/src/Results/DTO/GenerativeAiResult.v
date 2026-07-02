import rt

pub fn Class_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_id() string {
	return 'id'
}

pub fn Class_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_candidates() string {
	return 'candidates'
}

pub fn Class_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_token_usage() string {
	return 'tokenUsage'
}

pub fn Class_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_provider_metadata() string {
	return 'providerMetadata'
}

pub fn Class_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_model_metadata() string {
	return 'modelMetadata'
}

pub fn Class_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_additional_data() string {
	return 'additionalData'
}

struct Class_WordPress_AiClient_Results_DTO_GenerativeAiResult {
	rt.PhpObjectBase
pub mut:
	id               string
	candidates       rt.PhpVal = rt.new_null()
	tokenUsage       rt.PhpVal = rt.new_null()
	providerMetadata rt.PhpVal = rt.new_null()
	modelMetadata    rt.PhpVal = rt.new_null()
	additionalData   rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) construct(id string, mut var_candidates Class_WordPress_AiClient_Results_DTO_array, mut var_tokenUsage Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage, mut var_providerMetadata Class_WordPress_AiClient_Providers_DTO_ProviderMetadata, mut var_modelMetadata Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata, mut var_additionalData Class_WordPress_AiClient_Results_DTO_array) {
	mut var_candidates_mutated := var_candidates
	if !rt.is_true(var_candidates_mutated) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException',
			[]string{},
			create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('At least one candidate must be provided'))))
	}
	this.id = id
	this.candidates = var_candidates_mutated
	this.tokenUsage = var_tokenUsage
	this.providerMetadata = var_providerMetadata
	this.modelMetadata = var_modelMetadata
	this.additionalData = var_additionalData
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) getid() string {
	return this.id
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) getcandidates() rt.PhpVal {
	return this.candidates
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) gettokenusage() rt.PhpVal {
	return this.tokenUsage
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) getprovidermetadata() rt.PhpVal {
	return this.providerMetadata
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) getmodelmetadata() rt.PhpVal {
	return this.modelMetadata
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) getadditionaldata() rt.PhpVal {
	return this.additionalData
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) getcandidatecount() i64 {
	return this.candidates.array_count()
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) hasmultiplecandidates() bool {
	return rt.new_bool(this.getcandidatecount() > 1)
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) totext() string {
	mut var_message := rt.call_method(this.candidates.array_get(rt.new_int(0)), 'getMessage',
		[]rt.PhpVal{})
	mut iter_1 := rt.call_method(var_message, 'getParts', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_part := item_1.val
		mut var_channel := rt.call_method(var_part, 'getChannel', []rt.PhpVal{})
		mut var_text := rt.call_method(var_part, 'getText', []rt.PhpVal{})
		if rt.is_true(rt.call_method(var_channel, 'isContent', []rt.PhpVal{}))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_text, rt.new_null())))) {
			return var_text.str()
		}
	}
	rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException',
		[]string{},
		create_wordpress_aiclient_common_exception_runtimeexception(rt.new_string('No text content found in first candidate'))))
	return ''
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) tofile() rt.PhpVal {
	mut var_message := rt.call_method(this.candidates.array_get(rt.new_int(0)), 'getMessage',
		[]rt.PhpVal{})
	mut iter_2 := rt.call_method(var_message, 'getParts', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_part := item_2.val
		mut var_channel := rt.call_method(var_part, 'getChannel', []rt.PhpVal{})
		mut var_file := rt.call_method(var_part, 'getFile', []rt.PhpVal{})
		if rt.is_true(rt.call_method(var_channel, 'isContent', []rt.PhpVal{}))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_file, rt.new_null())))) {
			return var_file.clone()
		}
	}
	rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException',
		[]string{},
		create_wordpress_aiclient_common_exception_runtimeexception(rt.new_string('No file content found in first candidate'))))
	return rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) toimagefile() rt.PhpVal {
	mut var_file := this.tofile()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_file, 'isImage', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException',
			[]string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.call_function('sprintf', [
			rt.new_string('File is not an image. MIME type: %s'),
			rt.call_method(var_file, 'getMimeType', []rt.PhpVal{}),
		]))))
	}
	return var_file.clone()
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) toaudiofile() rt.PhpVal {
	mut var_file := this.tofile()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_file, 'isAudio', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException',
			[]string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.call_function('sprintf', [
			rt.new_string('File is not an audio file. MIME type: %s'),
			rt.call_method(var_file, 'getMimeType', []rt.PhpVal{}),
		]))))
	}
	return var_file.clone()
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) tovideofile() rt.PhpVal {
	mut var_file := this.tofile()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_file, 'isVideo', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException',
			[]string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.call_function('sprintf', [
			rt.new_string('File is not a video file. MIME type: %s'),
			rt.call_method(var_file, 'getMimeType', []rt.PhpVal{}),
		]))))
	}
	return var_file.clone()
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) tomessage() rt.PhpVal {
	return rt.call_method(this.candidates.array_get(rt.new_int(0)), 'getMessage', []rt.PhpVal{})
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) totexts() rt.PhpVal {
	mut var_texts := rt.new_array()
	mut iter_3 := this.candidates.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_candidate := item_3.val
		mut var_message := rt.call_method(var_candidate, 'getMessage', []rt.PhpVal{})
		mut iter_4 := rt.call_method(var_message, 'getParts', []rt.PhpVal{}).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_part := item_4.val
			mut var_channel := rt.call_method(var_part, 'getChannel', []rt.PhpVal{})
			mut var_text := rt.call_method(var_part, 'getText', []rt.PhpVal{})
			if rt.is_true(rt.call_method(var_channel, 'isContent', []rt.PhpVal{}))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_text, rt.new_null())))) {
				var_texts.array_push(var_text.clone())
				break
			}
		}
	}
	return var_texts.clone()
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) tofiles() rt.PhpVal {
	mut var_files := rt.new_array()
	mut iter_5 := this.candidates.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_candidate := item_5.val
		mut var_message := rt.call_method(var_candidate, 'getMessage', []rt.PhpVal{})
		mut iter_6 := rt.call_method(var_message, 'getParts', []rt.PhpVal{}).iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_part := item_6.val
			mut var_channel := rt.call_method(var_part, 'getChannel', []rt.PhpVal{})
			mut var_file := rt.call_method(var_part, 'getFile', []rt.PhpVal{})
			if rt.is_true(rt.call_method(var_channel, 'isContent', []rt.PhpVal{}))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_file, rt.new_null())))) {
				var_files.array_push(var_file.clone())
				break
			}
		}
	}
	return var_files.clone()
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) toimagefiles() rt.PhpVal {
	mut var_file := rt.new_null()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_file, 'isImage', []rt.PhpVal{})
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_file, 'isImage', []rt.PhpVal{})
	}
	return rt.call_function('array_values', [
		rt.call_function('array_filter', [this.tofiles(), rt.new_closure(closure_1_fn)]),
	])
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) toaudiofiles() rt.PhpVal {
	mut var_file := rt.new_null()
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_file, 'isAudio', []rt.PhpVal{})
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_file, 'isAudio', []rt.PhpVal{})
	}
	return rt.call_function('array_values', [
		rt.call_function('array_filter', [this.tofiles(), rt.new_closure(closure_3_fn)]),
	])
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) tovideofiles() rt.PhpVal {
	mut var_file := rt.new_null()
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_file, 'isVideo', []rt.PhpVal{})
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_file, 'isVideo', []rt.PhpVal{})
	}
	return rt.call_function('array_values', [
		rt.call_function('array_filter', [this.tofiles(), rt.new_closure(closure_5_fn)]),
	])
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) tomessages() rt.PhpVal {
	mut var_candidate := rt.new_null()
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_candidate := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_candidate, 'getMessage', []rt.PhpVal{})
	}
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_candidate := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_candidate, 'getMessage', []rt.PhpVal{})
	}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_candidate := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_candidate, 'getMessage', []rt.PhpVal{})
	}
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_candidate := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_candidate, 'getMessage', []rt.PhpVal{})
	}
	return rt.call_function('array_values', [
		rt.call_function('array_map', [rt.new_closure(closure_7_fn), this.candidates]),
	])
}

fn Class_WordPress_AiClient_Results_DTO_GenerativeAiResult.getjsonschema() rt.PhpVal {
	mut iife_temp_10 :=
		Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate{}
	mut iife_result_10 := iife_temp_10.getjsonschema()
	mut iife_temp_11 :=
		Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage{}
	mut iife_result_11 := iife_temp_11.getjsonschema()
	mut iife_temp_12 := Class_WordPress_AiClient_Providers_DTO_ProviderMetadata{}
	mut iife_result_12 := iife_temp_12.getjsonschema()
	mut iife_temp_13 := Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata{}
	mut iife_result_13 := iife_temp_13.getjsonschema()
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{
				key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_id()
				val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'description', val: 'Unique identifier for this result.' }])
			},
			rt.ArrayItem{
				key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_candidates()
				val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'items', val: iife_result_10 },
					rt.ArrayItem{ key: 'minItems', val: 1 }, rt.ArrayItem{
						key: 'description'
						val: 'The generated candidates.'
					}])
			},
			rt.ArrayItem{
				key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_token_usage()
				val: iife_result_11
			},
			rt.ArrayItem{
				key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_provider_metadata()
				val: iife_result_12
			},
			rt.ArrayItem{
				key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_model_metadata()
				val: iife_result_13
			},
			rt.ArrayItem{
				key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_additional_data()
				val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'additionalProperties', val: true },
					rt.ArrayItem{
						key: 'description'
						val: 'Additional data included in the API response.'
					}])
			},
		]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_id()
			},
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_candidates()
			},
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_token_usage()
			},
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_provider_metadata()
			},
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_model_metadata()
			},
		]) }])
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) toarray() rt.PhpVal {
	mut var_candidate := rt.new_null()
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_candidate := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_candidate, 'toArray', []rt.PhpVal{})
	}
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_candidate := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_candidate, 'toArray', []rt.PhpVal{})
	}
	return rt.create_array([
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_id()
			val: this.id
		},
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_candidates()
			val: rt.call_function('array_map', [rt.new_closure(closure_15_fn), this.candidates])
		},
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_token_usage()
			val: rt.call_method(this.tokenUsage, 'toArray', []rt.PhpVal{})
		},
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_provider_metadata()
			val: rt.call_method(this.providerMetadata, 'toArray', []rt.PhpVal{})
		},
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_model_metadata()
			val: rt.call_method(this.modelMetadata, 'toArray', []rt.PhpVal{})
		},
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_additional_data()
			val: this.additionalData
		},
	])
}

fn Class_WordPress_AiClient_Results_DTO_GenerativeAiResult.fromarray(mut var_array Class_WordPress_AiClient_Results_DTO_array) rt.PhpVal {
	mut var_candidateData := rt.new_null()
	mut iife_temp_16 := Class_WordPress_AiClient_Results_DTO_GenerativeAiResult{}
	mut iife_result_16 := iife_temp_16.validatefromarraydata(rt.new_object('WordPress_AiClient_Results_DTO_array',
		[]string{}, var_array), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_id()
		},
		rt.ArrayItem{
			key: none
			val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_candidates()
		},
		rt.ArrayItem{
			key: none
			val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_token_usage()
		},
		rt.ArrayItem{
			key: none
			val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_provider_metadata()
		},
		rt.ArrayItem{
			key: none
			val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_model_metadata()
		},
	]))
	closure_19_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_candidateData := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_18 :=
			Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate{}
		mut iife_result_18 := iife_temp_18.fromarray(var_candidateData.clone())
		return iife_result_18
	}
	closure_21_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_candidateData := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_20 :=
			Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate{}
		mut iife_result_20 := iife_temp_20.fromarray(var_candidateData.clone())
		return iife_result_20
	}
	mut var_candidates := rt.call_function('array_map', [rt.new_closure(closure_19_fn),
		var_array.array_get(Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_candidates())])
	mut iife_temp_21 :=
		Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage{}
	mut iife_result_21 :=
		iife_temp_21.fromarray(var_array.array_get(Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_token_usage()))
	mut iife_temp_22 := Class_WordPress_AiClient_Providers_DTO_ProviderMetadata{}
	mut iife_result_22 :=
		iife_temp_22.fromarray(var_array.array_get(Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_provider_metadata()))
	mut iife_temp_23 := Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata{}
	mut iife_result_23 :=
		iife_temp_23.fromarray(var_array.array_get(Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_model_metadata()))
	return rt.new_object('WordPress_AiClient_Results_DTO_self', []string{}, create_wordpress_aiclient_results_dto_self(var_array.array_get(Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_id()),
		var_candidates.clone(), iife_result_21, iife_result_22, iife_result_23, if !(var_array.array_get(Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_additional_data())).is_null() {
		var_array.array_get(Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_GenerativeAiResult.key_additional_data())
	} else {
		rt.new_array()
	}))
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) magic_clone() {
	mut var_clonedCandidates := rt.new_array()
	mut iter_7 := this.candidates.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_candidate := item_7.val
		var_clonedCandidates.array_push(var_candidate.dup())
	}
	this.candidates = var_clonedCandidates.clone()
	this.tokenUsage = this.tokenUsage.dup()
	this.providerMetadata = this.providerMetadata.dup()
	this.modelMetadata = this.modelMetadata.dup()
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_RuntimeException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_DTO_ProviderMetadata {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Results_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_results_dto_generativeairesult(id string, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal, arg_5 rt.PhpVal) &Class_WordPress_AiClient_Results_DTO_GenerativeAiResult {
	mut obj := &Class_WordPress_AiClient_Results_DTO_GenerativeAiResult{
		PhpObjectBase:    rt.PhpObjectBase{}
		id:               ''
		candidates:       rt.new_null()
		tokenUsage:       rt.new_null()
		providerMetadata: rt.new_null()
		modelMetadata:    rt.new_null()
		additionalData:   rt.new_null()
	}
	obj.construct(id, arg_1, arg_2, arg_3, arg_4, arg_5)
	return obj
}

fn create_wordpress_aiclient_common_abstractdatatransferobject(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	mut obj := &Class_WordPress_AiClient_Common_AbstractDataTransferObject{
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

fn create_wordpress_aiclient_results_dto_wordpress_aiclient_results_dto_candidate(_args ...rt.PhpVal) &Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate {
	mut obj := &Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_results_dto_wordpress_aiclient_results_dto_tokenusage(_args ...rt.PhpVal) &Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage {
	mut obj := &Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_dto_providermetadata(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_DTO_ProviderMetadata {
	mut obj := &Class_WordPress_AiClient_Providers_DTO_ProviderMetadata{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_models_dto_modelmetadata(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata{
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

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Results_DTO_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_DTO_ProviderMetadata](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata](if args.len > 4 {
				args[4]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_WordPress_AiClient_Results_DTO_array](if args.len > 5 {
				args[5]
			} else {
				rt.new_null()
			})
			this.construct(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut
				dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5)
			return rt.new_null()
		}
		'getId' {
			return rt.new_string(this.getid())
		}
		'getCandidates' {
			return this.getcandidates()
		}
		'getTokenUsage' {
			return this.gettokenusage()
		}
		'getProviderMetadata' {
			return this.getprovidermetadata()
		}
		'getModelMetadata' {
			return this.getmodelmetadata()
		}
		'getAdditionalData' {
			return this.getadditionaldata()
		}
		'getCandidateCount' {
			return rt.new_int(this.getcandidatecount())
		}
		'hasMultipleCandidates' {
			return rt.new_bool(this.hasmultiplecandidates())
		}
		'toText' {
			return rt.new_string(this.totext())
		}
		'toFile' {
			return this.tofile()
		}
		'toImageFile' {
			return this.toimagefile()
		}
		'toAudioFile' {
			return this.toaudiofile()
		}
		'toVideoFile' {
			return this.tovideofile()
		}
		'toMessage' {
			return this.tomessage()
		}
		'toTexts' {
			return this.totexts()
		}
		'toFiles' {
			return this.tofiles()
		}
		'toImageFiles' {
			return this.toimagefiles()
		}
		'toAudioFiles' {
			return this.toaudiofiles()
		}
		'toVideoFiles' {
			return this.tovideofiles()
		}
		'toMessages' {
			return this.tomessages()
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Results_DTO_GenerativeAiResult.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Results_DTO_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_WordPress_AiClient_Results_DTO_GenerativeAiResult.fromarray(mut dispatch_arg_0)
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return rt.new_string(this.id) }
		'candidates' { return this.candidates }
		'tokenUsage' { return this.tokenUsage }
		'providerMetadata' { return this.providerMetadata }
		'modelMetadata' { return this.modelMetadata }
		'additionalData' { return this.additionalData }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val.str()
			return true
		}
		'candidates' {
			this.candidates = val
			return true
		}
		'tokenUsage' {
			this.tokenUsage = val
			return true
		}
		'providerMetadata' {
			this.providerMetadata = val
			return true
		}
		'modelMetadata' {
			this.modelMetadata = val
			return true
		}
		'additionalData' {
			this.additionalData = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderMetadata) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_DTO_ProviderMetadata) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderMetadata) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
