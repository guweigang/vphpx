import rt

struct Class_WordPress_AiClient_Providers_AbstractProvider {
	rt.PhpObjectBase
}

fn init_static_wordpress_aiclient_providers_abstractprovider() {
		rt.init_static_prop('WordPress_AiClient_Providers_AbstractProvider', 'metadataCache', rt.new_array())
		rt.init_static_prop('WordPress_AiClient_Providers_AbstractProvider', 'availabilityCache', rt.new_array())
		rt.init_static_prop('WordPress_AiClient_Providers_AbstractProvider', 'modelMetadataDirectoryCache', rt.new_array())
}

fn Class_WordPress_AiClient_Providers_AbstractProvider.metadata() rt.PhpVal {
	mut var_className := Class_WordPress_AiClient_Providers_static.class()
	if !(rt.get_static_prop('WordPress_AiClient_Providers_AbstractProvider', 'metadataCache').array_isset(var_className)) {
		rt.get_static_prop('WordPress_AiClient_Providers_AbstractProvider', 'metadataCache').array_set(var_className, Class_WordPress_AiClient_Providers_AbstractProvider.createprovidermetadata())
	}
	return rt.get_static_prop('WordPress_AiClient_Providers_AbstractProvider', 'metadataCache').array_get(var_className)
}

fn Class_WordPress_AiClient_Providers_AbstractProvider.model(modelId string, mut var_modelConfig Class_WordPress_AiClient_Providers_?ModelConfig) rt.PhpVal {
	mut var_providerMetadata := Class_WordPress_AiClient_Providers_AbstractProvider.metadata()
	mut var_modelMetadata := rt.call_method(Class_WordPress_AiClient_Providers_AbstractProvider.modelmetadatadirectory(), 'getModelMetadata', [rt.new_string(modelId)])
	mut var_model := Class_WordPress_AiClient_Providers_AbstractProvider.createmodel(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata](var_modelMetadata), mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_DTO_ProviderMetadata](var_providerMetadata))
	if rt.is_true(var_modelConfig) {
		rt.call_method(var_model, 'setConfig', [var_modelConfig])
	}
	return var_model.clone()
}

fn Class_WordPress_AiClient_Providers_AbstractProvider.availability() rt.PhpVal {
	mut var_className := Class_WordPress_AiClient_Providers_static.class()
	if !(rt.get_static_prop('WordPress_AiClient_Providers_AbstractProvider', 'availabilityCache').array_isset(var_className)) {
		rt.get_static_prop('WordPress_AiClient_Providers_AbstractProvider', 'availabilityCache').array_set(var_className, Class_WordPress_AiClient_Providers_AbstractProvider.createprovideravailability())
	}
	return rt.get_static_prop('WordPress_AiClient_Providers_AbstractProvider', 'availabilityCache').array_get(var_className)
}

fn Class_WordPress_AiClient_Providers_AbstractProvider.modelmetadatadirectory() rt.PhpVal {
	mut var_className := Class_WordPress_AiClient_Providers_static.class()
	if !(rt.get_static_prop('WordPress_AiClient_Providers_AbstractProvider', 'modelMetadataDirectoryCache').array_isset(var_className)) {
		rt.get_static_prop('WordPress_AiClient_Providers_AbstractProvider', 'modelMetadataDirectoryCache').array_set(var_className, Class_WordPress_AiClient_Providers_AbstractProvider.createmodelmetadatadirectory())
	}
	return rt.get_static_prop('WordPress_AiClient_Providers_AbstractProvider', 'modelMetadataDirectoryCache').array_get(var_className)
}

fn Class_WordPress_AiClient_Providers_AbstractProvider.createmodel(mut var_modelMetadata Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata, mut var_providerMetadata Class_WordPress_AiClient_Providers_DTO_ProviderMetadata) {
	mut var_modelMetadata_mutated := var_modelMetadata
	mut var_providerMetadata_mutated := var_providerMetadata
}

fn Class_WordPress_AiClient_Providers_AbstractProvider.createprovidermetadata() {
}

fn Class_WordPress_AiClient_Providers_AbstractProvider.createprovideravailability() {
}

fn Class_WordPress_AiClient_Providers_AbstractProvider.createmodelmetadatadirectory() {
}

fn create_wordpress_aiclient_providers_abstractprovider(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_AbstractProvider {
	mut obj := &Class_WordPress_AiClient_Providers_AbstractProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_AbstractProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'metadata' {
			return Class_WordPress_AiClient_Providers_AbstractProvider.metadata()
		}
		'model' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_?ModelConfig](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_WordPress_AiClient_Providers_AbstractProvider.model(dispatch_arg_0, mut dispatch_arg_1)
		}
		'availability' {
			return Class_WordPress_AiClient_Providers_AbstractProvider.availability()
		}
		'modelMetadataDirectory' {
			return Class_WordPress_AiClient_Providers_AbstractProvider.modelmetadatadirectory()
		}
		'createModel' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_DTO_ProviderMetadata](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_WordPress_AiClient_Providers_AbstractProvider.createmodel(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'createProviderMetadata' {
			Class_WordPress_AiClient_Providers_AbstractProvider.createprovidermetadata()
			return rt.new_null()
		}
		'createProviderAvailability' {
			Class_WordPress_AiClient_Providers_AbstractProvider.createprovideravailability()
			return rt.new_null()
		}
		'createModelMetadataDirectory' {
			Class_WordPress_AiClient_Providers_AbstractProvider.createmodelmetadatadirectory()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Providers_AbstractProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_AbstractProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
