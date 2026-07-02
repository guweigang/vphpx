import rt

pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_capabilities() string {
	return 'requiredCapabilities'
}

pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_options() string {
	return 'requiredOptions'
}

struct Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements {
	rt.PhpObjectBase
pub mut:
	requiredCapabilities rt.PhpVal = rt.new_null()
	requiredOptions      rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) construct(mut var_requiredCapabilities Class_WordPress_AiClient_Providers_Models_DTO_array, mut var_requiredOptions Class_WordPress_AiClient_Providers_Models_DTO_array) {
	mut var_requiredOptions_mutated := var_requiredOptions
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_is_list', [
		var_requiredCapabilities,
	])))))
	{
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException',
			[]string{},
			create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Required capabilities must be a list array.'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_is_list', [
		var_requiredOptions_mutated,
	])))))
	{
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException',
			[]string{},
			create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Required options must be a list array.'))))
	}
	this.requiredCapabilities = var_requiredCapabilities
	this.requiredOptions = var_requiredOptions_mutated
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) getrequiredcapabilities() rt.PhpVal {
	return this.requiredCapabilities
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) getrequiredoptions() rt.PhpVal {
	return this.requiredOptions
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) aremetby(mut var_metadata Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata) bool {
	mut var_capabilitiesMap := rt.new_array()
	mut iter_1 := var_metadata.getsupportedcapabilities().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_capability := item_1.val
		var_capabilitiesMap.array_set(rt.get_property(var_capability, 'value'),
			var_capability.clone())
	}
	mut var_optionsMap := rt.new_array()
	mut iter_2 := var_metadata.getsupportedoptions().iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_option := item_2.val
		var_optionsMap.array_set(rt.get_property(rt.call_method(var_option, 'getName',
			[]rt.PhpVal{}), 'value'), var_option.clone())
	}
	mut iter_3 := this.requiredCapabilities.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_requiredCapability := item_3.val
		if !(var_capabilitiesMap.array_isset(rt.get_property(var_requiredCapability, 'value'))) {
			return false
		}
	}
	mut iter_4 := this.requiredOptions.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_requiredOption := item_4.val
		if !(var_optionsMap.array_isset(rt.get_property(rt.call_method(var_requiredOption,
			'getName', []rt.PhpVal{}), 'value'))) {
			return false
		}
		mut var_supportedOption := var_optionsMap.array_get(rt.get_property(rt.call_method(var_requiredOption,
			'getName', []rt.PhpVal{}), 'value'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_supportedOption,
			'isSupportedValue', [
			rt.call_method(var_requiredOption, 'getValue', []rt.PhpVal{}),
		])))))
		{
			return false
		}
	}
	return true
}

fn Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.frompromptdata(mut var_capability Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum, mut var_messages Class_WordPress_AiClient_Providers_Models_DTO_array, mut var_modelConfig Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig) rt.PhpVal {
	mut var_capabilities := rt.create_array([
		rt.ArrayItem{ key: none, val: var_capability },
	])
	mut var_inputModalities := rt.new_array()
	if var_messages.array_count() > 1 {
		mut iife_temp_0 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
		mut iife_result_0 := iife_temp_0.chathistory()
		var_capabilities.array_push(iife_result_0)
	}
	mut var_hasFunctionMessageParts := rt.new_bool(false)
	mut iter_5 := var_messages.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_message := item_5.val
		mut iter_6 := rt.call_method(var_message, 'getParts', []rt.PhpVal{}).iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_part := item_6.val
			if rt.is_true(rt.call_method(rt.call_method(var_part, 'getType', []rt.PhpVal{}),
				'isText', []rt.PhpVal{}))
			{
				mut iife_temp_1 := Class_WordPress_AiClient_Messages_Enums_ModalityEnum{}
				mut iife_result_1 := iife_temp_1.text()
				var_inputModalities.array_push(iife_result_1)
			}
			if rt.is_true(rt.call_method(rt.call_method(var_part, 'getType', []rt.PhpVal{}),
				'isFile', []rt.PhpVal{}))
			{
				mut var_file := rt.call_method(var_part, 'getFile', []rt.PhpVal{})
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_file, rt.new_null())))) {
					if rt.is_true(rt.call_method(var_file, 'isImage', []rt.PhpVal{})) {
						mut iife_temp_2 := Class_WordPress_AiClient_Messages_Enums_ModalityEnum{}
						mut iife_result_2 := iife_temp_2.image()
						var_inputModalities.array_push(iife_result_2)
					} else if rt.is_true(rt.call_method(var_file, 'isAudio', []rt.PhpVal{})) {
						mut iife_temp_3 := Class_WordPress_AiClient_Messages_Enums_ModalityEnum{}
						mut iife_result_3 := iife_temp_3.audio()
						var_inputModalities.array_push(iife_result_3)
					} else if rt.is_true(rt.call_method(var_file, 'isVideo', []rt.PhpVal{})) {
						mut iife_temp_4 := Class_WordPress_AiClient_Messages_Enums_ModalityEnum{}
						mut iife_result_4 := iife_temp_4.video()
						var_inputModalities.array_push(iife_result_4)
					} else if rt.is_true(rt.call_method(var_file, 'isDocument', []rt.PhpVal{}))
						|| rt.is_true(rt.call_method(var_file, 'isText', []rt.PhpVal{})) {
						mut iife_temp_5 := Class_WordPress_AiClient_Messages_Enums_ModalityEnum{}
						mut iife_result_5 := iife_temp_5.document()
						var_inputModalities.array_push(iife_result_5)
					}
				}
			}
			if rt.is_true(rt.call_method(rt.call_method(var_part, 'getType', []rt.PhpVal{}), 'isFunctionCall', []rt.PhpVal{}))
				|| rt.is_true(rt.call_method(rt.call_method(var_part, 'getType', []rt.PhpVal{}), 'isFunctionResponse', []rt.PhpVal{})) {
				var_hasFunctionMessageParts = rt.new_bool(true)
			}
		}
	}
	mut var_requiredOptions :=
		Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.torequiredoptions(mut var_modelConfig)
	if rt.is_true(var_hasFunctionMessageParts) {
		mut iife_temp_6 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_6 := iife_temp_6.functiondeclarations()
		var_requiredOptions = Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.includeinrequiredoptions(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](var_requiredOptions), mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption](create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_6,
			rt.new_bool(true))))
	}
	if !(!rt.is_true(var_inputModalities)) {
		var_inputModalities = rt.call_function('array_unique', [
			var_inputModalities.clone(), rt.get_constant('SORT_REGULAR')])
		mut iife_temp_7 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_7 := iife_temp_7.inputmodalities()
		var_requiredOptions = Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.includeinrequiredoptions(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](var_requiredOptions), mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption](create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_7, rt.call_function('array_values', [
			var_inputModalities.clone(),
		]))))
	}
	return rt.new_object('WordPress_AiClient_Providers_Models_DTO_self', []string{}, create_wordpress_aiclient_providers_models_dto_self(var_capabilities.clone(),
		var_requiredOptions.clone()))
}

fn Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.torequiredoptions(mut var_modelConfig Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig) rt.PhpVal {
	mut var_requiredOptions := rt.new_array()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.getoutputmodalities(),
		rt.new_null()))))
	{
		mut iife_temp_8 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_8 := iife_temp_8.outputmodalities()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_8,
			var_modelConfig.getoutputmodalities()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.getsysteminstruction(),
		rt.new_null()))))
	{
		mut iife_temp_9 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_9 := iife_temp_9.systeminstruction()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_9,
			var_modelConfig.getsysteminstruction()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.getcandidatecount(),
		rt.new_null()))))
	{
		mut iife_temp_10 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_10 := iife_temp_10.candidatecount()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_10,
			var_modelConfig.getcandidatecount()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.getmaxtokens(),
		rt.new_null()))))
	{
		mut iife_temp_11 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_11 := iife_temp_11.maxtokens()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_11,
			var_modelConfig.getmaxtokens()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.gettemperature(),
		rt.new_null()))))
	{
		mut iife_temp_12 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_12 := iife_temp_12.temperature()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_12,
			var_modelConfig.gettemperature()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.gettopp(), rt.new_null())))) {
		mut iife_temp_13 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_13 := iife_temp_13.topp()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_13,
			var_modelConfig.gettopp()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.gettopk(), rt.new_null())))) {
		mut iife_temp_14 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_14 := iife_temp_14.topk()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_14,
			var_modelConfig.gettopk()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.getoutputmimetype(),
		rt.new_null()))))
	{
		mut iife_temp_15 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_15 := iife_temp_15.outputmimetype()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_15,
			var_modelConfig.getoutputmimetype()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.getoutputschema(),
		rt.new_null()))))
	{
		mut iife_temp_16 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_16 := iife_temp_16.outputschema()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_16,
			var_modelConfig.getoutputschema()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.getstopsequences(),
		rt.new_null()))))
	{
		mut iife_temp_17 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_17 := iife_temp_17.stopsequences()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_17,
			var_modelConfig.getstopsequences()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.getpresencepenalty(),
		rt.new_null()))))
	{
		mut iife_temp_18 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_18 := iife_temp_18.presencepenalty()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_18,
			var_modelConfig.getpresencepenalty()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.getfrequencypenalty(),
		rt.new_null()))))
	{
		mut iife_temp_19 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_19 := iife_temp_19.frequencypenalty()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_19,
			var_modelConfig.getfrequencypenalty()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.getlogprobs(), rt.new_null())))) {
		mut iife_temp_20 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_20 := iife_temp_20.logprobs()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_20,
			var_modelConfig.getlogprobs()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.gettoplogprobs(),
		rt.new_null()))))
	{
		mut iife_temp_21 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_21 := iife_temp_21.toplogprobs()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_21,
			var_modelConfig.gettoplogprobs()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.getfunctiondeclarations(),
		rt.new_null()))))
	{
		mut iife_temp_22 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_22 := iife_temp_22.functiondeclarations()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_22,
			rt.new_bool(true)))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.getwebsearch(),
		rt.new_null()))))
	{
		mut iife_temp_23 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_23 := iife_temp_23.websearch()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_23,
			rt.new_bool(true)))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.getoutputfiletype(),
		rt.new_null()))))
	{
		mut iife_temp_24 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_24 := iife_temp_24.outputfiletype()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_24,
			var_modelConfig.getoutputfiletype()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.getoutputmediaorientation(),
		rt.new_null()))))
	{
		mut iife_temp_25 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_25 := iife_temp_25.outputmediaorientation()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_25,
			var_modelConfig.getoutputmediaorientation()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelConfig.getoutputmediaaspectratio(),
		rt.new_null()))))
	{
		mut iife_temp_26 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_26 := iife_temp_26.outputmediaaspectratio()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_26,
			var_modelConfig.getoutputmediaaspectratio()))
	}
	mut iter_7 := var_modelConfig.getcustomoptions().iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_value := item_7.val
		mut var_key := item_7.key
		mut iife_temp_27 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
		mut iife_result_27 := iife_temp_27.customoptions()
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(iife_result_27, rt.create_array([
			rt.ArrayItem{ key: var_key, val: var_value },
		])))
	}
	return var_requiredOptions.clone()
}

fn Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.includeinrequiredoptions(mut var_requiredOptions Class_WordPress_AiClient_Providers_Models_DTO_array, mut var_newOption Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption) rt.PhpVal {
	mut var_requiredOptions_mutated := var_requiredOptions
	mut iter_8 := var_requiredOptions_mutated.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_existingOption := item_8.val
		mut var_index := item_8.key
		if rt.is_true(rt.call_method(rt.call_method(var_existingOption, 'getName', []rt.PhpVal{}),
			'equals', [var_newOption.getname()]))
		{
			var_requiredOptions_mutated.array_set(var_index, var_newOption)
			return rt.new_object('WordPress_AiClient_Providers_Models_DTO_array', []string{},
				var_requiredOptions_mutated)
		}
	}
	var_requiredOptions_mutated.array_push(var_newOption)
	return rt.new_object('WordPress_AiClient_Providers_Models_DTO_array', []string{},
		var_requiredOptions_mutated)
}

fn Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.getjsonschema() rt.PhpVal {
	mut iife_temp_28 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
	mut iife_result_28 := iife_temp_28.getvalues()
	mut iife_temp_29 :=
		Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption{}
	mut iife_result_29 := iife_temp_29.getjsonschema()
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{
				key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_capabilities()
				val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'items', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'enum', val: iife_result_28 },
					]) }, rt.ArrayItem{
						key: 'description'
						val: 'The capabilities that the model must support.'
					}])
			},
			rt.ArrayItem{
				key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_options()
				val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'items', val: iife_result_29 },
					rt.ArrayItem{
						key: 'description'
						val: 'The options that the model must support with specific values.'
					}])
			},
		]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_capabilities()
			},
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_options()
			},
		]) }])
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) toarray() rt.PhpVal {
	mut var_capability := rt.new_null()
	mut var_option := rt.new_null()
	closure_31_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_capability := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.get_property(var_capability, 'value')
	}
	closure_32_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_capability := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.get_property(var_capability, 'value')
	}
	closure_33_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_option := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_option, 'toArray', []rt.PhpVal{})
	}
	closure_34_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_option := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_option, 'toArray', []rt.PhpVal{})
	}
	return rt.create_array([
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_capabilities()
			val: rt.call_function('array_map',
				[rt.new_closure(closure_31_fn), this.requiredCapabilities])
		},
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_options()
			val: rt.call_function('array_map',
				[rt.new_closure(closure_33_fn), this.requiredOptions])
		},
	])
}

fn Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.fromarray(mut var_array Class_WordPress_AiClient_Providers_Models_DTO_array) rt.PhpVal {
	mut var_capability := rt.new_null()
	mut var_optionData := rt.new_null()
	mut iife_temp_34 := Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements{}
	mut iife_result_34 := iife_temp_34.validatefromarraydata(rt.new_object('WordPress_AiClient_Providers_Models_DTO_array',
		[]string{}, var_array), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_capabilities()
		},
		rt.ArrayItem{
			key: none
			val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_options()
		},
	]))
	closure_37_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_capability := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_36 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
		mut iife_result_36 := iife_temp_36.from(rt.new_object('WordPress_AiClient_Providers_Models_Enums_CapabilityEnum',
			[]string{}, var_capability))
		return iife_result_36
	}
	closure_39_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_capability := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_38 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
		mut iife_result_38 := iife_temp_38.from(rt.new_object('WordPress_AiClient_Providers_Models_Enums_CapabilityEnum',
			[]string{}, var_capability))
		return iife_result_38
	}
	closure_41_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_optionData := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_40 :=
			Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption{}
		mut iife_result_40 := iife_temp_40.fromarray(var_optionData.clone())
		return iife_result_40
	}
	closure_43_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_optionData := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_42 :=
			Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption{}
		mut iife_result_42 := iife_temp_42.fromarray(var_optionData.clone())
		return iife_result_42
	}
	return rt.new_object('WordPress_AiClient_Providers_Models_DTO_self', []string{}, create_wordpress_aiclient_providers_models_dto_self(rt.call_function('array_map', [
		rt.new_closure(closure_37_fn),
		var_array.array_get(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_capabilities()),
	]), rt.call_function('array_map', [rt.new_closure(closure_41_fn),
		var_array.array_get(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_options())])))
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_Enums_ModalityEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Models_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_models_dto_modelrequirements(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements{
		PhpObjectBase:        rt.PhpObjectBase{}
		requiredCapabilities: rt.new_null()
		requiredOptions:      rt.new_null()
	}
	obj.construct(arg_0, arg_1)
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

fn create_wordpress_aiclient_providers_models_enums_capabilityenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum {
	mut obj := &Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{
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

fn create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_models_enums_optionenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum {
	mut obj := &Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_models_dto_self(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Models_DTO_self {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'getRequiredCapabilities' {
			return this.getrequiredcapabilities()
		}
		'getRequiredOptions' {
			return this.getrequiredoptions()
		}
		'areMetBy' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.aremetby(mut dispatch_arg_0))
		}
		'fromPromptData' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.frompromptdata(mut dispatch_arg_0, mut
				dispatch_arg_1, mut dispatch_arg_2)
		}
		'toRequiredOptions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.torequiredoptions(mut dispatch_arg_0)
		}
		'includeInRequiredOptions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.includeinrequiredoptions(mut dispatch_arg_0, mut
				dispatch_arg_1)
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.fromarray(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'requiredCapabilities' { return this.requiredCapabilities }
		'requiredOptions' { return this.requiredOptions }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'requiredCapabilities' {
			this.requiredCapabilities = val
			return true
		}
		'requiredOptions' {
			this.requiredOptions = val
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

fn (mut this Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Models_DTO_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
