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
		requiredOptions rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) construct(mut var_requiredCapabilities Class_WordPress_AiClient_Providers_Models_DTO_array, mut var_requiredOptions Class_WordPress_AiClient_Providers_Models_DTO_array)  {
	mut var_requiredOptions_mutated := var_requiredOptions
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_is_list', [var_requiredCapabilities]))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Required capabilities must be a list array.'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_is_list', [var_requiredOptions_mutated.dup()]))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Required options must be a list array.'))))
	}
	this.requiredCapabilities = var_requiredCapabilities.dup()
	this.requiredOptions = var_requiredOptions_mutated.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) getrequiredcapabilities() rt.PhpVal {
	return this.requiredCapabilities
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) getrequiredoptions() rt.PhpVal {
	return this.requiredOptions
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) aremetby(mut var_metadata Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata) bool {
	mut var_capabilitiesMap := rt.new_array()
	{
		mut iter_1 := var_metadata.getsupportedcapabilities().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_capability := item_1.val
			var_capabilitiesMap.array_set(rt.get_property(var_capability, 'value'), var_capability.dup())
		}
	}
	mut var_optionsMap := rt.new_array()
	{
		mut iter_1 := var_metadata.getsupportedoptions().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_option := item_1.val
			var_optionsMap.array_set(rt.get_property(rt.call_method(var_option, 'getName', []rt.PhpVal{}), 'value'), var_option.dup())
		}
	}
	{
		mut iter_1 := this.requiredCapabilities.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_requiredCapability := item_1.val
			if !(var_capabilitiesMap.array_isset(rt.get_property(var_requiredCapability, 'value'))) {
				return false
			}
		}
	}
	{
		mut iter_1 := this.requiredOptions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_requiredOption := item_1.val
			if !(var_optionsMap.array_isset(rt.get_property(rt.call_method(var_requiredOption, 'getName', []rt.PhpVal{}), 'value'))) {
				return false
			}
			mut var_supportedOption := var_optionsMap.array_get(rt.get_property(rt.call_method(var_requiredOption, 'getName', []rt.PhpVal{}), 'value'))
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_supportedOption, 'isSupportedValue', [rt.call_method(var_requiredOption, 'getValue', []rt.PhpVal{})]))))) {
				return false
			}
		}
	}
	return true
}

fn Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.frompromptdata(mut var_capability Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum, mut var_messages Class_WordPress_AiClient_Providers_Models_DTO_array, mut var_modelConfig Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig) rt.PhpVal {
	mut var_capabilities := rt.create_array([rt.ArrayItem{ key: none, val: var_capability }])
	mut var_inputModalities := rt.new_array()
	if var_messages.array_count() > 1 {
		var_capabilities.array_push(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}; return temp.chathistory() }())
	}
	mut var_hasFunctionMessageParts := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := var_messages.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_message := item_1.val
			{
				mut iter_2 := rt.call_method(var_message, 'getParts', []rt.PhpVal{}).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_part := item_2.val
					if rt.is_true(rt.call_method(rt.call_method(var_part, 'getType', []rt.PhpVal{}), 'isText', []rt.PhpVal{})) {
						var_inputModalities.array_push(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Messages_Enums_ModalityEnum{}; return temp.text() }())
					}
					if rt.is_true(rt.call_method(rt.call_method(var_part, 'getType', []rt.PhpVal{}), 'isFile', []rt.PhpVal{})) {
						mut var_file := rt.call_method(var_part, 'getFile', []rt.PhpVal{})
						if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
							if rt.is_true(rt.call_method(var_file, 'isImage', []rt.PhpVal{})) {
								var_inputModalities.array_push(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Messages_Enums_ModalityEnum{}; return temp.image() }())
							} else if rt.is_true(rt.call_method(var_file, 'isAudio', []rt.PhpVal{})) {
								var_inputModalities.array_push(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Messages_Enums_ModalityEnum{}; return temp.audio() }())
							} else if rt.is_true(rt.call_method(var_file, 'isVideo', []rt.PhpVal{})) {
								var_inputModalities.array_push(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Messages_Enums_ModalityEnum{}; return temp.video() }())
							} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_file, 'isDocument', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_file, 'isText', []rt.PhpVal{})))) {
								var_inputModalities.array_push(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Messages_Enums_ModalityEnum{}; return temp.document() }())
							}
						}
					}
					if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(rt.call_method(var_part, 'getType', []rt.PhpVal{}), 'isFunctionCall', []rt.PhpVal{})) || rt.is_true(rt.call_method(rt.call_method(var_part, 'getType', []rt.PhpVal{}), 'isFunctionResponse', []rt.PhpVal{})))) {
						var_hasFunctionMessageParts = rt.new_bool(rt.new_bool(true))
					}
				}
			}
		}
	}
	mut var_requiredOptions := Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.torequiredoptions(mut var_modelConfig)
	if rt.is_true(var_hasFunctionMessageParts) {
		var_requiredOptions = Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.includeinrequiredoptions(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](var_requiredOptions), mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption](create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.functiondeclarations() }(), rt.new_bool(true))))
	}
	if !(!rt.is_true(var_inputModalities)) {
		var_inputModalities = rt.call_function('array_unique', [var_inputModalities.dup(), rt.get_constant('SORT_REGULAR')])
		var_requiredOptions = Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.includeinrequiredoptions(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](var_requiredOptions), mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption](create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.inputmodalities() }(), rt.call_function('array_values', [var_inputModalities.dup()]))))
	}
	return create_wordpress_aiclient_providers_models_dto_self(var_capabilities.dup(), var_requiredOptions.dup())
}

fn Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.torequiredoptions(mut var_modelConfig Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig) rt.PhpVal {
	mut var_requiredOptions := rt.new_array()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.outputmodalities() }(), var_modelConfig.getoutputmodalities()))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.systeminstruction() }(), var_modelConfig.getsysteminstruction()))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.candidatecount() }(), var_modelConfig.getcandidatecount()))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.maxtokens() }(), var_modelConfig.getmaxtokens()))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.temperature() }(), var_modelConfig.gettemperature()))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.topp() }(), var_modelConfig.gettopp()))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.topk() }(), var_modelConfig.gettopk()))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.outputmimetype() }(), var_modelConfig.getoutputmimetype()))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.outputschema() }(), var_modelConfig.getoutputschema()))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.stopsequences() }(), var_modelConfig.getstopsequences()))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.presencepenalty() }(), var_modelConfig.getpresencepenalty()))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.frequencypenalty() }(), var_modelConfig.getfrequencypenalty()))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.logprobs() }(), var_modelConfig.getlogprobs()))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.toplogprobs() }(), var_modelConfig.gettoplogprobs()))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.functiondeclarations() }(), rt.new_bool(true)))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.websearch() }(), rt.new_bool(true)))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.outputfiletype() }(), var_modelConfig.getoutputfiletype()))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.outputmediaorientation() }(), var_modelConfig.getoutputmediaorientation()))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.outputmediaaspectratio() }(), var_modelConfig.getoutputmediaaspectratio()))
	}
	{
		mut iter_1 := var_modelConfig.getcustomoptions().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			var_requiredOptions.array_push(create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.customoptions() }(), rt.create_array([rt.ArrayItem{ key: var_key, val: var_value }])))
		}
	}
	return var_requiredOptions.dup()
}

fn Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.includeinrequiredoptions(mut var_requiredOptions Class_WordPress_AiClient_Providers_Models_DTO_array, mut var_newOption Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption) rt.PhpVal {
	mut var_requiredOptions_mutated := var_requiredOptions
	{
		mut iter_1 := var_requiredOptions_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_existingOption := item_1.val
			mut var_index := item_1.key
			if rt.is_true(rt.call_method(rt.call_method(var_existingOption, 'getName', []rt.PhpVal{}), 'equals', [var_newOption.getname()])) {
				var_requiredOptions_mutated.array_set(var_index, var_newOption.dup())
				return rt.new_object('WordPress_AiClient_Providers_Models_DTO_array', []string{}, var_requiredOptions_mutated)
			}
		}
	}
	var_requiredOptions_mutated.array_push(var_newOption.dup())
	return rt.new_object('WordPress_AiClient_Providers_Models_DTO_array', []string{}, var_requiredOptions_mutated)
}

fn Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.getjsonschema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_capabilities(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}; return temp.getvalues() }() }]) }, rt.ArrayItem{ key: 'description', val: 'The capabilities that the model must support.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_options(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption{}; return temp.getjsonschema() }() }, rt.ArrayItem{ key: 'description', val: 'The options that the model must support with specific values.' }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_capabilities() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_options() }]) }])
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) toarray() rt.PhpVal {
	mut var_capability := rt.new_null()
	mut var_option := rt.new_null()
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_capability := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_capability, 'value')
	}
	mut var_capability := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_capability, 'value')
	}
	mut var_option := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_option, 'toArray', []rt.PhpVal{})
	}
	mut var_option := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_option, 'toArray', []rt.PhpVal{})
	}
	return rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_capabilities(), val: rt.call_function('array_map', [rt.new_closure(closure_1_fn), this.requiredCapabilities]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_options(), val: rt.call_function('array_map', [rt.new_closure(closure_3_fn), this.requiredOptions]) }])
}

fn Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.fromarray(mut var_array Class_WordPress_AiClient_Providers_Models_DTO_array) rt.PhpVal {
	mut var_capability := rt.new_null()
	mut var_optionData := rt.new_null()
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements{}; return temp.validatefromarraydata(arg_0, arg_1) }(rt.new_object('WordPress_AiClient_Providers_Models_DTO_array', []string{}, var_array), rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_capabilities() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_options() }]))
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_capability := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}; return temp.from(arg_0) }(rt.new_object('WordPress_AiClient_Providers_Models_Enums_CapabilityEnum', []string{}, var_capability))
	}
	mut var_capability := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}; return temp.from(arg_0) }(rt.new_object('WordPress_AiClient_Providers_Models_Enums_CapabilityEnum', []string{}, var_capability))
	}
	mut var_optionData := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption{}; return temp.fromarray(arg_0) }(var_optionData.dup())
	}
	mut var_optionData := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption{}; return temp.fromarray(arg_0) }(var_optionData.dup())
	}
	return create_wordpress_aiclient_providers_models_dto_self(rt.call_function('array_map', [rt.new_closure(closure_5_fn), var_array.array_get(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_capabilities())]), rt.call_function('array_map', [rt.new_closure(closure_7_fn), var_array.array_get(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.key_required_options())]))
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
		PhpObjectBase: rt.PhpObjectBase{}
		requiredCapabilities: rt.new_null()
		requiredOptions: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
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

fn create_wordpress_aiclient_providers_models_enums_capabilityenum() &Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum {
	mut obj := &Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{
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

fn create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_requiredoption() &Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_models_enums_optionenum() &Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum {
	mut obj := &Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_models_dto_self() &Class_WordPress_AiClient_Providers_Models_DTO_self {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 1 { args[1] } else { rt.new_null() })
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.aremetby(mut dispatch_arg_0))
		}
		'fromPromptData' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.frompromptdata(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'toRequiredOptions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelConfig](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.torequiredoptions(mut dispatch_arg_0)
		}
		'includeInRequiredOptions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.includeinrequiredoptions(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements.fromarray(mut dispatch_arg_0)
		}
		else { return none }
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
		'requiredCapabilities' { this.requiredCapabilities = val; return true }
		'requiredOptions' { this.requiredOptions = val; return true }
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




pub fn init_wp_includes_php_ai_client_src_providers_models_dto_modelrequirements_php() {
	// unsupported statement: Stmt_Declare
}
