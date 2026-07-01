import rt

struct Class_WordPress_AiClient_Providers_ProviderRegistry {
	rt.PhpObjectBase
pub mut:
		registeredIdsToClassNames rt.PhpVal = rt.new_array()
		registeredClassNamesToIds rt.PhpVal = rt.new_array()
		providerAuthenticationInstances rt.PhpVal = rt.new_array()
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) registerprovider(className string)  {
	mut className_mutated := className
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string(className_mutated).dup()]))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Provider class does not exist: %s'), rt.new_string(className_mutated).dup()]))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subclass_of', [rt.new_string(className_mutated).dup(), Class_WordPress_AiClient_Providers_Contracts_ProviderInterface.class()]))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Provider class must implement %s: %s'), Class_WordPress_AiClient_Providers_Contracts_ProviderInterface.class(), rt.new_string(className_mutated).dup()]))))
	}
	mut var_metadata := fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":67,"name":"className"}{}; return temp.metadata() }()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_metadata, 'WordPress_AiClient_Providers_DTO_ProviderMetadata')))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Provider must return ProviderMetadata from metadata() method: %s'), rt.new_string(className_mutated).dup()]))))
	}
	mut var_httpTransporter := this.gethttptransporter()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WordPress_AiClient_Common_Exception_RuntimeException') {
		mut var_e := var_e_1.dup()
		this.sethttptransporter(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_Contracts_HttpTransporterInterface](fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory{}; return temp.createtransporter() }()))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		var_httpTransporter = this.gethttptransporter()
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		unsafe { goto end_label_2 }

catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'WordPress_AiClientDependencies_Http_Discovery_Exception_NotFoundException') {
			mut var_e := var_e_2.dup()
			// unsupported statement: Stmt_Nop
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
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			this.providerAuthenticationInstances.array_set(className_mutated, var_defaultProviderAuthentication.dup())
		}
	}
	if this.providerAuthenticationInstances.array_isset(rt.new_string(className_mutated)) {
		this.setrequestauthenticationforprovider(className_mutated, mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_Contracts_RequestAuthenticationInterface](this.providerAuthenticationInstances.array_get(className_mutated)))
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
		return (this.registeredIdsToClassNames.array_get(idOrClassName)).str()
	}
	rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Provider not registered: %s'), rt.new_string(idOrClassName)]))))
	return ''
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) getproviderid(idOrClassName string) string {
	if this.isregisteredid(idOrClassName) {
		return idOrClassName
	}
	if this.isregisteredclassname(idOrClassName) {
		return (this.registeredClassNamesToIds.array_get(idOrClassName)).str()
	}
	rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Provider not registered: %s'), rt.new_string(idOrClassName)]))))
	return ''
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) isproviderconfigured(idOrClassName string) bool {
	mut var_className := rt.new_string(this.resolveproviderclassname(idOrClassName))
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_availability := fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":190,"name":"className"}{}; return temp.availability() }()
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	return (rt.call_method(var_availability, 'isConfigured', []rt.PhpVal{})).to_bool()
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'WordPress_AiClient_Common_Exception_InvalidArgumentException') {
		mut var_e := var_e_3.dup()
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
	{
		mut iter_1 := this.registeredIdsToClassNames.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_className := item_1.val
			mut var_providerId := item_1.key
			mut var_providerResults := this.findprovidermodelsmetadataforsupport((var_providerId).str(), mut var_modelRequirements)
			if !(!rt.is_true(var_providerResults)) {
				mut var_providerMetadata := fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":212,"name":"className"}{}; return temp.metadata() }()
				var_results.array_push(create_wordpress_aiclient_providers_dto_providermodelsmetadata(var_providerMetadata.dup(), var_providerResults.dup()))
			}
		}
	}
	return var_results.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) findprovidermodelsmetadataforsupport(idOrClassName string, mut var_modelRequirements Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) rt.PhpVal {
	mut var_className := rt.new_string(this.resolveproviderclassname(idOrClassName))
	if !(this.isproviderconfigured((var_className).str())) {
		return rt.new_array()
	}
	mut var_modelMetadataDirectory := fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":234,"name":"className"}{}; return temp.modelmetadatadirectory() }()
	mut var_matchingModels := rt.new_array()
	{
		mut iter_1 := rt.call_method(var_modelMetadataDirectory, 'listModelMetadata', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_modelMetadata := item_1.val
			if rt.is_true(var_modelRequirements.aremetby(var_modelMetadata.dup())) {
				var_matchingModels.array_push(var_modelMetadata.dup())
			}
		}
	}
	return var_matchingModels.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) getprovidermodel(idOrClassName string, modelId string, mut var_modelConfig Class_WordPress_AiClient_Providers_?ModelConfig) rt.PhpVal {
	mut var_className := rt.new_string(this.resolveproviderclassname(idOrClassName))
	mut var_modelInstance := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":258,"name":"className"}{}; return temp.model(arg_0, arg_1) }(rt.new_string(modelId), rt.new_object('WordPress_AiClient_Providers_?ModelConfig', []string{}, var_modelConfig))
	this.bindmodeldependencies(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface](var_modelInstance))
	return var_modelInstance.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) bindmodeldependencies(mut var_modelInstance Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface)  {
	mut var_modelInstance_mutated := var_modelInstance
	mut var_className := rt.new_string(this.resolveproviderclassname((rt.call_method(rt.call_method(var_modelInstance_mutated, 'providerMetadata', []rt.PhpVal{}), 'getId', []rt.PhpVal{})).str()))
	if rt.is_true(rt.new_bool(rt.instance_of(var_modelInstance_mutated, 'WordPress_AiClient_Providers_Http_Contracts_WithHttpTransporterInterface'))) {
		rt.call_method(var_modelInstance_mutated, 'setHttpTransporter', [this.gethttptransporter()])
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_modelInstance_mutated, 'WordPress_AiClient_Providers_Http_Contracts_WithRequestAuthenticationInterface'))) {
		mut var_requestAuthentication := this.getproviderrequestauthentication((var_className).str())
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_method(var_modelInstance_mutated, 'setRequestAuthentication', [var_requestAuthentication.dup()])
		}
	}
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) resolveproviderclassname(idOrClassName string) string {
	if this.isregisteredclassname(idOrClassName) {
		return idOrClassName
	}
	if this.isregisteredid(idOrClassName) {
		return (this.registeredIdsToClassNames.array_get(idOrClassName)).str()
	}
	rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Provider not registered: %s'), rt.new_string(idOrClassName)]))))
	return ''
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) sethttptransporter(mut var_httpTransporter Class_WordPress_AiClient_Providers_Http_Contracts_HttpTransporterInterface)  {
	mut var_httpTransporter_mutated := var_httpTransporter
	this.sethttptransporteroriginal(rt.new_object('WordPress_AiClient_Providers_Http_Contracts_HttpTransporterInterface', []string{}, var_httpTransporter_mutated))
	{
		mut iter_1 := this.registeredIdsToClassNames.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_className := item_1.val
			this.sethttptransporterforprovider((var_className).str(), mut var_httpTransporter_mutated)
		}
	}
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) setproviderrequestauthentication(idOrClassName string, mut var_requestAuthentication Class_WordPress_AiClient_Providers_Http_Contracts_RequestAuthenticationInterface)  {
	mut var_requestAuthentication_mutated := var_requestAuthentication
	mut var_className := rt.new_string(this.resolveproviderclassname(idOrClassName))
	this.providerAuthenticationInstances.array_set(var_className, var_requestAuthentication_mutated.dup())
	this.setrequestauthenticationforprovider((var_className).str(), mut var_requestAuthentication_mutated)
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) getproviderrequestauthentication(idOrClassName string) rt.PhpVal {
	mut var_className := rt.new_string(this.resolveproviderclassname(idOrClassName))
	if !(this.providerAuthenticationInstances.array_isset(var_className)) {
		return rt.new_null()
	}
	return this.providerAuthenticationInstances.array_get(var_className)
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) sethttptransporterforprovider(className string, mut var_httpTransporter Class_WordPress_AiClient_Providers_Http_Contracts_HttpTransporterInterface)  {
	mut className_mutated := className
	mut var_httpTransporter_mutated := var_httpTransporter
	mut var_availability := fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":359,"name":"className"}{}; return temp.availability() }()
	if rt.is_true(rt.new_bool(rt.instance_of(var_availability, 'WordPress_AiClient_Providers_Http_Contracts_WithHttpTransporterInterface'))) {
		rt.call_method(var_availability, 'setHttpTransporter', [var_httpTransporter_mutated.dup()])
	}
	mut var_modelMetadataDirectory := fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":363,"name":"className"}{}; return temp.modelmetadatadirectory() }()
	if rt.is_true(rt.new_bool(rt.instance_of(var_modelMetadataDirectory, 'WordPress_AiClient_Providers_Http_Contracts_WithHttpTransporterInterface'))) {
		rt.call_method(var_modelMetadataDirectory, 'setHttpTransporter', [var_httpTransporter_mutated.dup()])
	}
	if rt.is_true(rt.call_function('is_subclass_of', [rt.new_string(className_mutated).dup(), Class_WordPress_AiClient_Providers_Contracts_ProviderWithOperationsHandlerInterface.class()])) {
		mut var_operationsHandler := fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":368,"name":"className"}{}; return temp.operationshandler() }()
		if rt.is_true(rt.new_bool(rt.instance_of(var_operationsHandler, 'WordPress_AiClient_Providers_Http_Contracts_WithHttpTransporterInterface'))) {
			rt.call_method(var_operationsHandler, 'setHttpTransporter', [var_httpTransporter_mutated.dup()])
		}
	}
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) setrequestauthenticationforprovider(className string, mut var_requestAuthentication Class_WordPress_AiClient_Providers_Http_Contracts_RequestAuthenticationInterface)  {
	mut className_mutated := className
	mut var_requestAuthentication_mutated := var_requestAuthentication
	mut var_authenticationMethod := rt.call_method(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":386,"name":"className"}{}; return temp.metadata() }(), 'getAuthenticationMethod', []rt.PhpVal{})
	if rt.is_true(rt.identical(var_authenticationMethod, rt.new_null())) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Provider %s does not expect any authentication, but got %s.'), rt.new_string(className_mutated).dup(), rt.call_function('get_class', [var_requestAuthentication_mutated.dup()])]))))
	}
	mut var_expectedClass := rt.call_method(var_authenticationMethod, 'getImplementationClass', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_requestAuthentication_mutated, 'WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":391,"name":"expectedClass"}')))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Provider %s expects authentication of type %s, but got %s.'), rt.new_string(className_mutated).dup(), var_expectedClass.dup(), rt.call_function('get_class', [var_requestAuthentication_mutated.dup()])]))))
	}
	mut var_availability := fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":394,"name":"className"}{}; return temp.availability() }()
	if rt.is_true(rt.new_bool(rt.instance_of(var_availability, 'WordPress_AiClient_Providers_Http_Contracts_WithRequestAuthenticationInterface'))) {
		rt.call_method(var_availability, 'setRequestAuthentication', [var_requestAuthentication_mutated.dup()])
	}
	mut var_modelMetadataDirectory := fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":398,"name":"className"}{}; return temp.modelmetadatadirectory() }()
	if rt.is_true(rt.new_bool(rt.instance_of(var_modelMetadataDirectory, 'WordPress_AiClient_Providers_Http_Contracts_WithRequestAuthenticationInterface'))) {
		rt.call_method(var_modelMetadataDirectory, 'setRequestAuthentication', [var_requestAuthentication_mutated.dup()])
	}
	if rt.is_true(rt.call_function('is_subclass_of', [rt.new_string(className_mutated).dup(), Class_WordPress_AiClient_Providers_Contracts_ProviderWithOperationsHandlerInterface.class()])) {
		mut var_operationsHandler := fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":403,"name":"className"}{}; return temp.operationshandler() }()
		if rt.is_true(rt.new_bool(rt.instance_of(, 'WordPress_AiClient_Providers_Http_Contracts_WithRequestAuthenticationInterface'))) {
			
		}
	}
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) createdefaultproviderrequestauthentication(className string) rt.PhpVal {
	mut className_mutated := className
	mut var_providerMetadata := 
	
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) isregisteredclassname(idOrClassName string) bool {
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) isregisteredid(idOrClassName string) bool {
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) getenvvarname(providerId string, field string) string {
	mut providerId_mutated := providerId
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

fn create_wordpress_aiclient_providers_providerregistry() &Class_WordPress_AiClient_Providers_ProviderRegistry {
	mut obj := &Class_WordPress_AiClient_Providers_ProviderRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
		registeredIdsToClassNames: rt.new_array()
		registeredClassNamesToIds: rt.new_array()
		providerAuthenticationInstances: rt.new_array()
	}
	return obj
}

fn create_wordpress_aiclient_common_exception_invalidargumentexception() &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":67,"name":"classname"}() &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":67,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":67,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_httptransporterfactory() &Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory {
	mut obj := &Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":190,"name":"classname"}() &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":190,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":190,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":212,"name":"classname"}() &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":212,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":212,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_dto_providermodelsmetadata() &Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata {
	mut obj := &Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":234,"name":"classname"}() &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":234,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":234,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":258,"name":"classname"}() &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":258,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":258,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":359,"name":"classname"}() &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":359,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":359,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":363,"name":"classname"}() &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":363,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":363,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":368,"name":"classname"}() &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":368,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":368,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":386,"name":"classname"}() &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":386,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":386,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":394,"name":"classname"}() &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":394,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":394,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":398,"name":"classname"}() &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":398,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":398,"name":"className"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_{"nodetype":"expr_variable","line":403,"name":"classname"}() &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":403,"name":"className"} {
	mut obj := &Class_WordPress_AiClient_Providers_{"nodeType":"Expr_Variable","line":403,"name":"className"}{
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




pub fn init_wp_includes_php_ai_client_src_providers_providerregistry_php() {
	// unsupported statement: Stmt_Declare
}
