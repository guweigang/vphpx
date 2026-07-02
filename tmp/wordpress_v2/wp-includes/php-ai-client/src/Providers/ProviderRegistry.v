import rt

struct Class_WordPress_AiClient_Providers_ProviderRegistry {
	rt.PhpObjectBase
pub mut:
		registeredIdsToClassNames rt.PhpVal = rt.new_array()
		registeredClassNamesToIds rt.PhpVal = rt.new_array()
		providerAuthenticationInstances rt.PhpVal = rt.new_array()
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) registerprovider(className string) {
	mut className_mutated := className
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string(className_mutated).clone()]))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Provider class does not exist: %s'), rt.new_string(className_mutated).clone()]))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subclass_of', [rt.new_string(className_mutated).clone(), Class_WordPress_AiClient_Providers_Contracts_ProviderInterface.class()]))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Provider class must implement %s: %s'), Class_WordPress_AiClient_Providers_Contracts_ProviderInterface.class(), rt.new_string(className_mutated).clone()]))))
	}
	mut iife_temp_0 := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":67,"name":"className"}{}
	mut iife_result_0 := iife_temp_0.metadata()
	mut var_metadata := iife_result_0
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_metadata, 'WordPress_AiClient_Providers_DTO_ProviderMetadata')))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Provider must return ProviderMetadata from metadata() method: %s'), rt.new_string(className_mutated).clone()]))))
	}
	mut var_httpTransporter := this.gethttptransporter()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WordPress_AiClient_Common_Exception_RuntimeException') {
		mut var_e := var_e_1.clone()
		mut iife_temp_1 := Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory{}
		mut iife_result_1 := iife_temp_1.createtransporter()
		this.sethttptransporter(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_Contracts_HttpTransporterInterface](iife_result_1))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		var_httpTransporter = this.gethttptransporter()
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		unsafe { goto end_label_2 }

catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'WordPress_AiClientDependencies_Http_Discovery_Exception_NotFoundException') {
			var_e = var_e_2.clone()
			unsafe { goto end_label_2 }
		}
		else {
			rt.throw_exception(var_e_2)
			unsafe { goto end_label_2 }
		}

end_label_2:
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	if !(var_httpTransporter).is_null() {
		this.sethttptransporterforprovider(className_mutated, mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_Contracts_HttpTransporterInterface](var_httpTransporter))
	}
	if !(this.providerAuthenticationInstances.array_isset(rt.new_string(className_mutated))) {
		mut var_defaultProviderAuthentication := this.createdefaultproviderrequestauthentication(className_mutated)
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_defaultProviderAuthentication, rt.new_null())))) {
			this.providerAuthenticationInstances.array_set(className_mutated, var_defaultProviderAuthentication.clone())
		}
	}
	if this.providerAuthenticationInstances.array_isset(rt.new_string(className_mutated)) {
		this.setrequestauthenticationforprovider(className_mutated, mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_Contracts_RequestAuthenticationInterface](this.providerAuthenticationInstances.array_get(rt.new_string(className_mutated))))
	}
	this.registeredIdsToClassNames.array_set(rt.call_method(var_metadata, 'getId', []rt.PhpVal{}), className_mutated)
	this.registeredClassNamesToIds.array_set(className_mutated, rt.call_method(var_metadata, 'getId', []rt.PhpVal{}))
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) getregisteredproviderids() rt.PhpVal {
	return rt.func_array_keys(this.registeredIdsToClassNames)
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) hasprovider(idOrClassName string) bool {
	return this.isregisteredid(idOrClassName) || this.isregisteredclassname(idOrClassName)
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) getproviderclassname(idOrClassName string) string {
	if this.isregisteredclassname(idOrClassName) {
		return idOrClassName
	}
	if this.isregisteredid(idOrClassName) {
		return (this.registeredIdsToClassNames.array_get(rt.new_string(idOrClassName))).str()
	}
	rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Provider not registered: %s'), rt.new_string(idOrClassName)]))))
	return ''
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) getproviderid(idOrClassName string) string {
	if this.isregisteredid(idOrClassName) {
		return idOrClassName
	}
	if this.isregisteredclassname(idOrClassName) {
		return (this.registeredClassNamesToIds.array_get(rt.new_string(idOrClassName))).str()
	}
	rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Provider not registered: %s'), rt.new_string(idOrClassName)]))))
	return ''
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) isproviderconfigured(idOrClassName string) bool {
	mut var_className := rt.new_string(this.resolveproviderclassname(idOrClassName))
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut iife_temp_2 := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":190,"name":"className"}{}
	mut iife_result_2 := iife_temp_2.availability()
	mut var_availability := iife_result_2
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	return (rt.call_method(var_availability, 'isConfigured', []rt.PhpVal{})).to_bool()
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'WordPress_AiClient_Common_Exception_InvalidArgumentException') {
		mut var_e := var_e_3.clone()
		return false
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	return false
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) findmodelsmetadataforsupport(mut var_modelRequirements Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) rt.PhpVal {
	mut var_results := rt.new_array()
	mut iter_1 := this.registeredIdsToClassNames.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_className := item_1.val
		mut var_providerId := item_1.key
		mut var_providerResults := this.findprovidermodelsmetadataforsupport((var_providerId).str(), mut var_modelRequirements)
		if !(!rt.is_true(var_providerResults)) {
			mut iife_temp_3 := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":212,"name":"className"}{}
			mut iife_result_3 := iife_temp_3.metadata()
			mut var_providerMetadata := iife_result_3
			var_results.array_push(create_wordpress_aiclient_providers_dto_providermodelsmetadata(var_providerMetadata.clone(), var_providerResults.clone()))
		}
	}
	return var_results.clone()
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) findprovidermodelsmetadataforsupport(idOrClassName string, mut var_modelRequirements Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) rt.PhpVal {
	mut var_className := rt.new_string(this.resolveproviderclassname(idOrClassName))
	if !(this.isproviderconfigured((var_className).str())) {
		return rt.new_array()
	}
	mut iife_temp_4 := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":234,"name":"className"}{}
	mut iife_result_4 := iife_temp_4.modelmetadatadirectory()
	mut var_modelMetadataDirectory := iife_result_4
	mut var_matchingModels := rt.new_array()
	mut iter_2 := rt.call_method(var_modelMetadataDirectory, 'listModelMetadata', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_modelMetadata := item_2.val
		if rt.is_true(var_modelRequirements.aremetby(var_modelMetadata.clone())) {
			var_matchingModels.array_push(var_modelMetadata.clone())
		}
	}
	return var_matchingModels.clone()
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) getprovidermodel(idOrClassName string, modelId string, mut var_modelConfig Class_WordPress_AiClient_Providers_?ModelConfig) rt.PhpVal {
	mut var_className := rt.new_string(this.resolveproviderclassname(idOrClassName))
	mut iife_temp_5 := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":258,"name":"className"}{}
	mut iife_result_5 := iife_temp_5.model(rt.new_string(modelId), rt.new_object('WordPress_AiClient_Providers_?ModelConfig', []string{}, var_modelConfig))
	mut var_modelInstance := iife_result_5
	this.bindmodeldependencies(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface](var_modelInstance))
	return var_modelInstance.clone()
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) bindmodeldependencies(mut var_modelInstance Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface) {
	mut var_modelInstance_mutated := var_modelInstance
	mut var_className := rt.new_string(this.resolveproviderclassname((rt.call_method(rt.call_method(var_modelInstance_mutated, 'providerMetadata', []rt.PhpVal{}), 'getId', []rt.PhpVal{})).str()))
	if rt.is_true(rt.new_bool(rt.instance_of(var_modelInstance_mutated, 'WordPress_AiClient_Providers_Http_Contracts_WithHttpTransporterInterface'))) {
		rt.call_method(var_modelInstance_mutated, 'setHttpTransporter', [this.gethttptransporter()])
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_modelInstance_mutated, 'WordPress_AiClient_Providers_Http_Contracts_WithRequestAuthenticationInterface'))) {
		mut var_requestAuthentication := this.getproviderrequestauthentication((var_className).str())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_requestAuthentication, rt.new_null())))) {
			rt.call_method(var_modelInstance_mutated, 'setRequestAuthentication', [var_requestAuthentication.clone()])
		}
	}
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) resolveproviderclassname(idOrClassName string) string {
	if this.isregisteredclassname(idOrClassName) {
		return idOrClassName
	}
	if this.isregisteredid(idOrClassName) {
		return (this.registeredIdsToClassNames.array_get(rt.new_string(idOrClassName))).str()
	}
	rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Provider not registered: %s'), rt.new_string(idOrClassName)]))))
	return ''
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) sethttptransporter(mut var_httpTransporter Class_WordPress_AiClient_Providers_Http_Contracts_HttpTransporterInterface) {
	mut var_httpTransporter_mutated := var_httpTransporter
	this.sethttptransporteroriginal(rt.new_object('WordPress_AiClient_Providers_Http_Contracts_HttpTransporterInterface', []string{}, var_httpTransporter_mutated))
	mut iter_3 := this.registeredIdsToClassNames.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_className := item_3.val
		this.sethttptransporterforprovider((var_className).str(), mut var_httpTransporter_mutated)
	}
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) setproviderrequestauthentication(idOrClassName string, mut var_requestAuthentication Class_WordPress_AiClient_Providers_Http_Contracts_RequestAuthenticationInterface) {
	mut var_requestAuthentication_mutated := var_requestAuthentication
	mut var_className := rt.new_string(this.resolveproviderclassname(idOrClassName))
	this.providerAuthenticationInstances.array_set(var_className, var_requestAuthentication_mutated)
	this.setrequestauthenticationforprovider((var_className).str(), mut var_requestAuthentication_mutated)
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) getproviderrequestauthentication(idOrClassName string) rt.PhpVal {
	mut var_className := rt.new_string(this.resolveproviderclassname(idOrClassName))
	if !(this.providerAuthenticationInstances.array_isset(var_className)) {
		return rt.new_null()
	}
	return this.providerAuthenticationInstances.array_get(var_className)
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) sethttptransporterforprovider(className string, mut var_httpTransporter Class_WordPress_AiClient_Providers_Http_Contracts_HttpTransporterInterface) {
	mut className_mutated := className
	mut var_httpTransporter_mutated := var_httpTransporter
	mut iife_temp_6 := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":359,"name":"className"}{}
	mut iife_result_6 := iife_temp_6.availability()
	mut var_availability := iife_result_6
	if rt.is_true(rt.new_bool(rt.instance_of(var_availability, 'WordPress_AiClient_Providers_Http_Contracts_WithHttpTransporterInterface'))) {
		rt.call_method(var_availability, 'setHttpTransporter', [var_httpTransporter_mutated])
	}
	mut iife_temp_7 := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":363,"name":"className"}{}
	mut iife_result_7 := iife_temp_7.modelmetadatadirectory()
	mut var_modelMetadataDirectory := iife_result_7
	if rt.is_true(rt.new_bool(rt.instance_of(var_modelMetadataDirectory, 'WordPress_AiClient_Providers_Http_Contracts_WithHttpTransporterInterface'))) {
		rt.call_method(var_modelMetadataDirectory, 'setHttpTransporter', [var_httpTransporter_mutated])
	}
	if rt.is_true(rt.call_function('is_subclass_of', [rt.new_string(className_mutated).clone(), Class_WordPress_AiClient_Providers_Contracts_ProviderWithOperationsHandlerInterface.class()])) {
		mut iife_temp_8 := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":368,"name":"className"}{}
		mut iife_result_8 := iife_temp_8.operationshandler()
		mut var_operationsHandler := iife_result_8
		if rt.is_true(rt.new_bool(rt.instance_of(var_operationsHandler, 'WordPress_AiClient_Providers_Http_Contracts_WithHttpTransporterInterface'))) {
			rt.call_method(var_operationsHandler, 'setHttpTransporter', [var_httpTransporter_mutated])
		}
	}
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) setrequestauthenticationforprovider(className string, mut var_requestAuthentication Class_WordPress_AiClient_Providers_Http_Contracts_RequestAuthenticationInterface) {
	mut className_mutated := className
	mut var_requestAuthentication_mutated := var_requestAuthentication
	mut iife_temp_9 := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":386,"name":"className"}{}
	mut iife_result_9 := iife_temp_9.metadata()
	mut var_authenticationMethod := rt.call_method(iife_result_9, 'getAuthenticationMethod', []rt.PhpVal{})
	if rt.is_true(rt.identical(var_authenticationMethod, rt.new_null())) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Provider %s does not expect any authentication, but got %s.'), rt.new_string(className_mutated).clone(), rt.call_function('get_class', [var_requestAuthentication_mutated])]))))
	}
	mut var_expectedClass := rt.call_method(var_authenticationMethod, 'getImplementationClass', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_requestAuthentication_mutated, 'WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":391,"name":"expectedClass"}')))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Provider %s expects authentication of type %s, but got %s.'), rt.new_string(className_mutated).clone(), var_expectedClass.clone(), rt.call_function('get_class', [var_requestAuthentication_mutated])]))))
	}
	mut iife_temp_10 := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":394,"name":"className"}{}
	mut iife_result_10 := iife_temp_10.availability()
	mut var_availability := iife_result_10
	if rt.is_true(rt.new_bool(rt.instance_of(var_availability, 'WordPress_AiClient_Providers_Http_Contracts_WithRequestAuthenticationInterface'))) {
		rt.call_method(var_availability, 'setRequestAuthentication', [var_requestAuthentication_mutated])
	}
	mut iife_temp_11 := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":398,"name":"className"}{}
	mut iife_result_11 := iife_temp_11.modelmetadatadirectory()
	mut var_modelMetadataDirectory := iife_result_11
	if rt.is_true(rt.new_bool(rt.instance_of(var_modelMetadataDirectory, 'WordPress_AiClient_Providers_Http_Contracts_WithRequestAuthenticationInterface'))) {
		rt.call_method(var_modelMetadataDirectory, 'setRequestAuthentication', [var_requestAuthentication_mutated])
	}
	if rt.is_true(rt.call_function('is_subclass_of', [rt.new_string(className_mutated).clone(), Class_WordPress_AiClient_Providers_Contracts_ProviderWithOperationsHandlerInterface.class()])) {
		mut iife_temp_12 := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":403,"name":"className"}{}
		mut iife_result_12 := iife_temp_12.operationshandler()
		mut var_operationsHandler := iife_result_12
		if rt.is_true(rt.new_bool(rt.instance_of(var_operationsHandler, 'WordPress_AiClient_Providers_Http_Contracts_WithRequestAuthenticationInterface'))) {
			rt.call_method(var_operationsHandler, 'setRequestAuthentication', [var_requestAuthentication_mutated])
		}
	}
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) createdefaultproviderrequestauthentication(className string) rt.PhpVal {
	mut className_mutated := className
	mut iife_temp_13 := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":420,"name":"className"}{}
	mut iife_result_13 := iife_temp_13.metadata()
	mut var_providerMetadata := iife_result_13
	mut var_providerId := rt.call_method(var_providerMetadata, 'getId', []rt.PhpVal{})
	mut var_authenticationMethod := rt.call_method(var_providerMetadata, 'getAuthenticationMethod', []rt.PhpVal{})
	if rt.is_true(rt.identical(var_authenticationMethod, rt.new_null())) {
		return rt.new_null()
	}
	mut var_authenticationClass := rt.call_method(var_authenticationMethod, 'getImplementationClass', []rt.PhpVal{})
	if rt.is_true(rt.identical(var_authenticationClass, rt.new_null())) {
		return rt.new_null()
	}
	mut iife_temp_14 := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":430,"name":"authenticationClass"}{}
	mut iife_result_14 := iife_temp_14.getjsonschema()
	mut var_authenticationSchema := iife_result_14
	mut var_authenticationData := rt.new_array()
	if var_authenticationSchema.array_isset(rt.new_string('properties')) && var_authenticationSchema.array_get(rt.new_string('properties')).is_array() {
		mut iter_4 := var_authenticationSchema.array_get(rt.new_string('properties')).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_details := item_4.val
			mut var_property := item_4.key
			mut var_envVarName := rt.new_string(this.getenvvarname((var_providerId).str(), (var_property).str()))
			mut var_envValue := rt.call_function('getenv', [var_envVarName.clone()])
			if rt.is_true(rt.identical(var_envValue, rt.new_bool(false))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [var_envVarName.clone()]))))) {
					continue
				}
				var_envValue = rt.call_function('constant', [var_envVarName.clone()])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_envValue.clone()]))))) {
					continue
				}
			}
			if var_details.array_isset(rt.new_string('type')) {
				mut switch_val_1 := var_details.array_get(rt.new_string('type'))
				if rt.is_true(rt.equal(switch_val_1, rt.new_string('boolean'))) {
					var_authenticationData.array_set(var_property, rt.call_function('filter_var', [var_envValue.clone(), rt.get_constant('FILTER_VALIDATE_BOOLEAN')]))
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('number'))) {
					var_authenticationData.array_set(var_property, rt.new_int((var_envValue).to_i64()))
				} else {
					var_authenticationData.array_set(var_property, (var_envValue).str())
				}
			} else {
				var_authenticationData.array_set(var_property, (var_envValue).str())
			}
		}
		if var_authenticationSchema.array_isset(rt.new_string('required')) && var_authenticationSchema.array_get(rt.new_string('required')).is_array() {
			mut var_requiredProperties := var_authenticationSchema.array_get(rt.new_string('required'))
			if rt.is_true(rt.call_function('array_diff_key', [rt.call_function('array_flip', [var_requiredProperties.clone()]), var_authenticationData.clone()])) {
				return rt.new_null()
			}
		}
	}
	mut iife_temp_15 := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":477,"name":"authenticationClass"}{}
	mut iife_result_15 := iife_temp_15.fromarray(var_authenticationData.clone())
	return iife_result_15
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) isregisteredclassname(idOrClassName string) bool {
	return (rt.new_bool(this.registeredClassNamesToIds.array_isset(rt.new_string(idOrClassName)))).to_bool()
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) isregisteredid(idOrClassName string) bool {
	return (rt.new_bool(this.registeredIdsToClassNames.array_isset(rt.new_string(idOrClassName)))).to_bool()
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) getenvvarname(providerId string, field string) string {
	mut providerId_mutated := providerId
	mut var_constantCaseProviderId := rt.new_string((rt.call_function('preg_replace', [rt.new_string('/([a-z])([A-Z])/'), rt.new_string('$1_$2'), rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), rt.new_string(providerId_mutated).clone()])])).str().to_upper())
	mut var_constantCaseField := rt.new_string((rt.call_function('preg_replace', [rt.new_string('/([a-z])([A-Z])/'), rt.new_string('$1_$2'), rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), rt.new_string(field)])])).str().to_upper())
	return "${var_constantCaseProviderId.to_string()}_${var_constantCaseField.to_string()}"
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":67,"name":"className"} {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":190,"name":"className"} {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":212,"name":"className"} {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":234,"name":"className"} {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":258,"name":"className"} {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":359,"name":"className"} {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":363,"name":"className"} {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":368,"name":"className"} {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":386,"name":"className"} {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":394,"name":"className"} {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":398,"name":"className"} {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":403,"name":"className"} {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":420,"name":"className"} {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":430,"name":"authenticationClass"} {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":477,"name":"authenticationClass"} {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_providerregistry(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_ProviderRegistry {
	mut obj := &Class_WordPress_AiClient_Providers_ProviderRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
		registeredIdsToClassNames: rt.new_array()
		registeredClassNamesToIds: rt.new_array()
		providerAuthenticationInstances: rt.new_array()
	}
	return obj
}

fn create_wordpress_aiclient_common_exception_invalidargumentexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":67,"name":"classname"}(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":67,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":67,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_httptransporterfactory(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory {
	mut obj := &Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":190,"name":"classname"}(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":190,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":190,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":212,"name":"classname"}(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":212,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":212,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_dto_providermodelsmetadata(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata {
	mut obj := &Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":234,"name":"classname"}(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":234,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":234,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":258,"name":"classname"}(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":258,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":258,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":359,"name":"classname"}(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":359,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":359,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":363,"name":"classname"}(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":363,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":363,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":368,"name":"classname"}(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":368,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":368,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":386,"name":"classname"}(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":386,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":386,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":394,"name":"classname"}(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":394,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":394,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":398,"name":"classname"}(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":398,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":398,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":403,"name":"classname"}(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":403,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":403,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":420,"name":"classname"}(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":420,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":420,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":430,"name":"authenticationclass"}(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":430,"name":"authenticationClass"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":430,"name":"authenticationClass"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":477,"name":"authenticationclass"}(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":477,"name":"authenticationClass"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":477,"name":"authenticationClass"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'registerProvider' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.registerprovider(dispatch_arg_0)
			return rt.new_null()
		}
		'getRegisteredProviderIds' {
			return this.getregisteredproviderids()
		}
		'hasProvider' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.hasprovider(dispatch_arg_0))
		}
		'getProviderClassName' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.getproviderclassname(dispatch_arg_0))
		}
		'getProviderId' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.getproviderid(dispatch_arg_0))
		}
		'isProviderConfigured' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.isproviderconfigured(dispatch_arg_0))
		}
		'findModelsMetadataForSupport' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.findmodelsmetadataforsupport(mut dispatch_arg_0)
		}
		'findProviderModelsMetadataForSupport' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.findprovidermodelsmetadataforsupport(dispatch_arg_0, mut dispatch_arg_1)
		}
		'getProviderModel' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_?ModelConfig](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.getprovidermodel(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'bindModelDependencies' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			this.bindmodeldependencies(mut dispatch_arg_0)
			return rt.new_null()
		}
		'resolveProviderClassName' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.resolveproviderclassname(dispatch_arg_0))
		}
		'setHttpTransporter' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_Contracts_HttpTransporterInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			this.sethttptransporter(mut dispatch_arg_0)
			return rt.new_null()
		}
		'setProviderRequestAuthentication' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_Contracts_RequestAuthenticationInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			this.setproviderrequestauthentication(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'getProviderRequestAuthentication' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.getproviderrequestauthentication(dispatch_arg_0)
		}
		'setHttpTransporterForProvider' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_Contracts_HttpTransporterInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			this.sethttptransporterforprovider(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'setRequestAuthenticationForProvider' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_Contracts_RequestAuthenticationInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			this.setrequestauthenticationforprovider(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'createDefaultProviderRequestAuthentication' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.createdefaultproviderrequestauthentication(dispatch_arg_0)
		}
		'isRegisteredClassName' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.isregisteredclassname(dispatch_arg_0))
		}
		'isRegisteredId' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.isregisteredid(dispatch_arg_0))
		}
		'getEnvVarName' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.getenvvarname(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Providers_ProviderRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registeredIdsToClassNames' { return this.registeredIdsToClassNames }
		'registeredClassNamesToIds' { return this.registeredClassNamesToIds }
		'providerAuthenticationInstances' { return this.providerAuthenticationInstances }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registeredIdsToClassNames' { this.registeredIdsToClassNames = val; return true }
		'registeredClassNamesToIds' { this.registeredClassNamesToIds = val; return true }
		'providerAuthenticationInstances' { this.providerAuthenticationInstances = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":67,"name":"className"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":67,"name":"className"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":67,"name":"className"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":190,"name":"className"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":190,"name":"className"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":190,"name":"className"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":212,"name":"className"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":212,"name":"className"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":212,"name":"className"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":234,"name":"className"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":234,"name":"className"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":234,"name":"className"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":258,"name":"className"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":258,"name":"className"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":258,"name":"className"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":359,"name":"className"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":359,"name":"className"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":359,"name":"className"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":363,"name":"className"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":363,"name":"className"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":363,"name":"className"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":368,"name":"className"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":368,"name":"className"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":368,"name":"className"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":386,"name":"className"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":386,"name":"className"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":386,"name":"className"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":394,"name":"className"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":394,"name":"className"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":394,"name":"className"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":398,"name":"className"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":398,"name":"className"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":398,"name":"className"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":403,"name":"className"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":403,"name":"className"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":403,"name":"className"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":420,"name":"className"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":420,"name":"className"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":420,"name":"className"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":430,"name":"authenticationClass"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":430,"name":"authenticationClass"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":430,"name":"authenticationClass"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":477,"name":"authenticationClass"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":477,"name":"authenticationClass"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":477,"name":"authenticationClass"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
