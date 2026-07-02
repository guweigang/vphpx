import rt

struct Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel {
	rt.PhpObjectBase
pub mut:
	metadata         rt.PhpVal = rt.new_null()
	providerMetadata rt.PhpVal = rt.new_null()
	config           rt.PhpVal = rt.new_null()
	requestOptions   rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel) construct(mut var_metadata Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata, mut var_providerMetadata Class_WordPress_AiClient_Providers_DTO_ProviderMetadata) {
	this.metadata = var_metadata
	this.providerMetadata = var_providerMetadata
	mut iife_temp_0 := Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig{}
	mut iife_result_0 := iife_temp_0.fromarray(rt.new_array())
	this.config = iife_result_0
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel) metadata() rt.PhpVal {
	return this.metadata
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel) providermetadata() rt.PhpVal {
	return this.providerMetadata
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel) setconfig(mut var_config Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) {
	this.config = var_config
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel) getconfig() rt.PhpVal {
	return this.config
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel) setrequestoptions(mut var_requestOptions Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) {
	this.requestOptions = var_requestOptions
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel) getrequestoptions() rt.PhpVal {
	return this.requestOptions
}

struct Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_apibasedimplementation_abstractapibasedmodel(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel {
	mut obj := &Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel{
		PhpObjectBase:    rt.PhpObjectBase{}
		metadata:         rt.new_null()
		providerMetadata: rt.new_null()
		config:           rt.new_null()
		requestOptions:   rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_wordpress_aiclient_providers_models_dto_modelconfig(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_DTO_ProviderMetadata](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'metadata' {
			return this.metadata()
		}
		'providerMetadata' {
			return this.providermetadata()
		}
		'setConfig' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.setconfig(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getConfig' {
			return this.getconfig()
		}
		'setRequestOptions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.setrequestoptions(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getRequestOptions' {
			return this.getrequestoptions()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'metadata' { return this.metadata }
		'providerMetadata' { return this.providerMetadata }
		'config' { return this.config }
		'requestOptions' { return this.requestOptions }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'metadata' {
			this.metadata = val
			return true
		}
		'providerMetadata' {
			this.providerMetadata = val
			return true
		}
		'config' {
			this.config = val
			return true
		}
		'requestOptions' {
			this.requestOptions = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
