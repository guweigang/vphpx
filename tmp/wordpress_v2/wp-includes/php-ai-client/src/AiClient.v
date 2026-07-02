import rt

pub fn Class_WordPress_AiClient_AiClient.version() string {
	return '1.3.1'
}
struct Class_WordPress_AiClient_AiClient {
	rt.PhpObjectBase
}

fn init_static_wordpress_aiclient_aiclient() {
		rt.init_static_prop('WordPress_AiClient_AiClient', 'defaultRegistry', rt.new_null())
		rt.init_static_prop('WordPress_AiClient_AiClient', 'eventDispatcher', rt.new_null())
		rt.init_static_prop('WordPress_AiClient_AiClient', 'cache', rt.new_null())
}

fn Class_WordPress_AiClient_AiClient.defaultregistry() rt.PhpVal {
	if rt.is_true(rt.identical(rt.get_static_prop('WordPress_AiClient_AiClient', 'defaultRegistry'), rt.new_null())) {
		rt.set_static_prop('WordPress_AiClient_AiClient', 'defaultRegistry', rt.new_object('WordPress_AiClient_Providers_ProviderRegistry', []string{}, create_wordpress_aiclient_providers_providerregistry()))
	}
	return rt.get_static_prop('WordPress_AiClient_AiClient', 'defaultRegistry')
}

fn Class_WordPress_AiClient_AiClient.seteventdispatcher(mut var_dispatcher Class_WordPress_AiClient_?EventDispatcherInterface) {
	rt.set_static_prop('WordPress_AiClient_AiClient', 'eventDispatcher', var_dispatcher)
}

fn Class_WordPress_AiClient_AiClient.geteventdispatcher() rt.PhpVal {
	return rt.get_static_prop('WordPress_AiClient_AiClient', 'eventDispatcher')
}

fn Class_WordPress_AiClient_AiClient.setcache(mut var_cache Class_WordPress_AiClient_?CacheInterface) {
	rt.set_static_prop('WordPress_AiClient_AiClient', 'cache', var_cache)
}

fn Class_WordPress_AiClient_AiClient.getcache() rt.PhpVal {
	return rt.get_static_prop('WordPress_AiClient_AiClient', 'cache')
}

fn Class_WordPress_AiClient_AiClient.isconfigured(var_availabilityOrIdOrClassName rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.instance_of(var_availabilityOrIdOrClassName, 'WordPress_AiClient_Providers_Contracts_ProviderAvailabilityInterface'))) {
		return (rt.call_method(var_availabilityOrIdOrClassName, 'isConfigured', []rt.PhpVal{})).to_bool()
	}
	if rt.is_true(rt.new_bool(var_availabilityOrIdOrClassName.clone().is_string())) {
		return (rt.call_method(Class_WordPress_AiClient_AiClient.defaultregistry(), 'isProviderConfigured', [var_availabilityOrIdOrClassName.clone()])).to_bool()
	}
	rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception('Parameter must be a ProviderAvailabilityInterface instance, provider ID string, or provider class name. ' + (rt.call_function('sprintf', [rt.new_string('Received: %s'), if var_availabilityOrIdOrClassName.clone().is_object() { rt.call_function('get_class', [var_availabilityOrIdOrClassName.clone()]) } else { rt.call_function('gettype', [var_availabilityOrIdOrClassName.clone()]) }])).str())))
	return false
}

fn Class_WordPress_AiClient_AiClient.prompt(var_prompt rt.PhpVal, mut var_registry Class_WordPress_AiClient_?ProviderRegistry) rt.PhpVal {
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, create_wordpress_aiclient_builders_promptbuilder(if !(var_registry).is_null() { var_registry } else { Class_WordPress_AiClient_AiClient.defaultregistry() }, var_prompt.clone(), rt.get_static_prop('WordPress_AiClient_AiClient', 'eventDispatcher')))
}

fn Class_WordPress_AiClient_AiClient.generateresult(var_prompt rt.PhpVal, var_modelOrConfig rt.PhpVal, mut var_registry Class_WordPress_AiClient_?ProviderRegistry) rt.PhpVal {
	Class_WordPress_AiClient_AiClient.validatemodelorconfigparameter(var_modelOrConfig.clone())
	return rt.call_method(Class_WordPress_AiClient_AiClient.getconfiguredpromptbuilder(mut rt.cast_object_ptr[Class_WordPress_AiClient_?ProviderRegistry](var_prompt), var_modelOrConfig.clone(), rt.new_object('WordPress_AiClient_?ProviderRegistry', []string{}, var_registry)), 'generateResult', []rt.PhpVal{})
}

fn Class_WordPress_AiClient_AiClient.generatetextresult(var_prompt rt.PhpVal, var_modelOrConfig rt.PhpVal, mut var_registry Class_WordPress_AiClient_?ProviderRegistry) rt.PhpVal {
	Class_WordPress_AiClient_AiClient.validatemodelorconfigparameter(var_modelOrConfig.clone())
	return rt.call_method(Class_WordPress_AiClient_AiClient.getconfiguredpromptbuilder(mut rt.cast_object_ptr[Class_WordPress_AiClient_?ProviderRegistry](var_prompt), var_modelOrConfig.clone(), rt.new_object('WordPress_AiClient_?ProviderRegistry', []string{}, var_registry)), 'generateTextResult', []rt.PhpVal{})
}

fn Class_WordPress_AiClient_AiClient.generateimageresult(var_prompt rt.PhpVal, var_modelOrConfig rt.PhpVal, mut var_registry Class_WordPress_AiClient_?ProviderRegistry) rt.PhpVal {
	Class_WordPress_AiClient_AiClient.validatemodelorconfigparameter(var_modelOrConfig.clone())
	return rt.call_method(Class_WordPress_AiClient_AiClient.getconfiguredpromptbuilder(mut rt.cast_object_ptr[Class_WordPress_AiClient_?ProviderRegistry](var_prompt), var_modelOrConfig.clone(), rt.new_object('WordPress_AiClient_?ProviderRegistry', []string{}, var_registry)), 'generateImageResult', []rt.PhpVal{})
}

fn Class_WordPress_AiClient_AiClient.converttexttospeechresult(var_prompt rt.PhpVal, var_modelOrConfig rt.PhpVal, mut var_registry Class_WordPress_AiClient_?ProviderRegistry) rt.PhpVal {
	Class_WordPress_AiClient_AiClient.validatemodelorconfigparameter(var_modelOrConfig.clone())
	return rt.call_method(Class_WordPress_AiClient_AiClient.getconfiguredpromptbuilder(mut rt.cast_object_ptr[Class_WordPress_AiClient_?ProviderRegistry](var_prompt), var_modelOrConfig.clone(), rt.new_object('WordPress_AiClient_?ProviderRegistry', []string{}, var_registry)), 'convertTextToSpeechResult', []rt.PhpVal{})
}

fn Class_WordPress_AiClient_AiClient.generatespeechresult(var_prompt rt.PhpVal, var_modelOrConfig rt.PhpVal, mut var_registry Class_WordPress_AiClient_?ProviderRegistry) rt.PhpVal {
	Class_WordPress_AiClient_AiClient.validatemodelorconfigparameter(var_modelOrConfig.clone())
	return rt.call_method(Class_WordPress_AiClient_AiClient.getconfiguredpromptbuilder(mut rt.cast_object_ptr[Class_WordPress_AiClient_?ProviderRegistry](var_prompt), var_modelOrConfig.clone(), rt.new_object('WordPress_AiClient_?ProviderRegistry', []string{}, var_registry)), 'generateSpeechResult', []rt.PhpVal{})
}

fn Class_WordPress_AiClient_AiClient.generatevideoresult(var_prompt rt.PhpVal, var_modelOrConfig rt.PhpVal, mut var_registry Class_WordPress_AiClient_?ProviderRegistry) rt.PhpVal {
	Class_WordPress_AiClient_AiClient.validatemodelorconfigparameter(var_modelOrConfig.clone())
	return rt.call_method(Class_WordPress_AiClient_AiClient.getconfiguredpromptbuilder(mut rt.cast_object_ptr[Class_WordPress_AiClient_?ProviderRegistry](var_prompt), var_modelOrConfig.clone(), rt.new_object('WordPress_AiClient_?ProviderRegistry', []string{}, var_registry)), 'generateVideoResult', []rt.PhpVal{})
}

fn Class_WordPress_AiClient_AiClient.message(mut var_text Class_WordPress_AiClient_?string) {
	rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{}, create_wordpress_aiclient_common_exception_runtimeexception('MessageBuilder is not yet available. This method depends on builder infrastructure. ' + 'Use direct generation methods (generateTextResult, generateImageResult, etc.) for now.')))
}

fn Class_WordPress_AiClient_AiClient.validatemodelorconfigparameter(var_modelOrConfig rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_modelOrConfig, rt.new_null())))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_modelOrConfig, 'WordPress_AiClient_Providers_Models_Contracts_ModelInterface')))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_modelOrConfig, 'WordPress_AiClient_Providers_Models_DTO_ModelConfig')))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception('Parameter must be a ModelInterface instance (specific model), ' + 'ModelConfig instance (for auto-discovery), or null (default auto-discovery). ' + (rt.call_function('sprintf', [rt.new_string('Received: %s'), if var_modelOrConfig.clone().is_object() { rt.call_function('get_class', [var_modelOrConfig.clone()]) } else { rt.call_function('gettype', [var_modelOrConfig.clone()]) }])).str())))
	}
}

fn Class_WordPress_AiClient_AiClient.getconfiguredpromptbuilder(var_prompt rt.PhpVal, var_modelOrConfig rt.PhpVal, mut var_registry Class_WordPress_AiClient_?ProviderRegistry) rt.PhpVal {
	mut var_builder := Class_WordPress_AiClient_AiClient.prompt(var_prompt.clone(), mut var_registry)
	if rt.is_true(rt.new_bool(rt.instance_of(var_modelOrConfig, 'WordPress_AiClient_Providers_Models_Contracts_ModelInterface'))) {
		rt.call_method(var_builder, 'usingModel', [var_modelOrConfig.clone()])
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_modelOrConfig, 'WordPress_AiClient_Providers_Models_DTO_ModelConfig'))) {
		rt.call_method(var_builder, 'usingModelConfig', [var_modelOrConfig.clone()])
	}
	return var_builder.clone()
}

struct Class_WordPress_AiClient_Providers_ProviderRegistry {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Builders_PromptBuilder {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_RuntimeException {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_aiclient(_args ...rt.PhpVal) &Class_WordPress_AiClient_AiClient {
	mut obj := &Class_WordPress_AiClient_AiClient{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_providerregistry(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_ProviderRegistry {
	mut obj := &Class_WordPress_AiClient_Providers_ProviderRegistry{
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

fn create_wordpress_aiclient_builders_promptbuilder(_args ...rt.PhpVal) &Class_WordPress_AiClient_Builders_PromptBuilder {
	mut obj := &Class_WordPress_AiClient_Builders_PromptBuilder{
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

fn (mut this Class_WordPress_AiClient_AiClient) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'defaultRegistry' {
			return Class_WordPress_AiClient_AiClient.defaultregistry()
		}
		'setEventDispatcher' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_?EventDispatcherInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_WordPress_AiClient_AiClient.seteventdispatcher(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getEventDispatcher' {
			return Class_WordPress_AiClient_AiClient.geteventdispatcher()
		}
		'setCache' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_?CacheInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_WordPress_AiClient_AiClient.setcache(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getCache' {
			return Class_WordPress_AiClient_AiClient.getcache()
		}
		'isConfigured' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WordPress_AiClient_AiClient.isconfigured(dispatch_arg_0))
		}
		'prompt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_?ProviderRegistry](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_WordPress_AiClient_AiClient.prompt(dispatch_arg_0, mut dispatch_arg_1)
		}
		'generateResult' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_?ProviderRegistry](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_WordPress_AiClient_AiClient.generateresult(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'generateTextResult' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_?ProviderRegistry](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_WordPress_AiClient_AiClient.generatetextresult(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'generateImageResult' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_?ProviderRegistry](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_WordPress_AiClient_AiClient.generateimageresult(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'convertTextToSpeechResult' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_?ProviderRegistry](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_WordPress_AiClient_AiClient.converttexttospeechresult(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'generateSpeechResult' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_?ProviderRegistry](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_WordPress_AiClient_AiClient.generatespeechresult(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'generateVideoResult' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_?ProviderRegistry](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_WordPress_AiClient_AiClient.generatevideoresult(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'message' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_WordPress_AiClient_AiClient.message(mut dispatch_arg_0)
			return rt.new_null()
		}
		'validateModelOrConfigParameter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WordPress_AiClient_AiClient.validatemodelorconfigparameter(dispatch_arg_0)
			return rt.new_null()
		}
		'getConfiguredPromptBuilder' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_?ProviderRegistry](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_WordPress_AiClient_AiClient.getconfiguredpromptbuilder(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_AiClient) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_AiClient) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_ProviderRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_ProviderRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Builders_PromptBuilder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

}
