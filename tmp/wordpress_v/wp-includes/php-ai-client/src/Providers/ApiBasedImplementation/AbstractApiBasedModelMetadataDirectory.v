import rt
import crypto.md5

pub fn Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory.models_cache_key() string {
	return 'models'
}

struct Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory {
	rt.PhpObjectBase
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory) listmodelmetadata() rt.PhpVal {
	mut var_modelsMetadata := this.getmodelmetadatamap()
	return rt.call_function('array_values', [var_modelsMetadata.dup()])
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory) hasmodelmetadata(modelId string) bool {
	mut var_modelsMetadata := this.getmodelmetadatamap()
	return (rt.new_bool(var_modelsMetadata.array_isset(rt.new_string(modelId)))).to_bool()
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory) getmodelmetadata(modelId string) rt.PhpVal {
	mut var_modelsMetadata := this.getmodelmetadatamap()
	if !(var_modelsMetadata.array_isset(rt.new_string(modelId))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException',
			[]string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [
			rt.new_string('No model with ID %s was found in the provider'),
			rt.new_string(modelId),
		]))))
	}
	return var_modelsMetadata.array_get(modelId)
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory) getmodelmetadatamap() rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.sendlistmodelsrequest()
	}
	return this.cached(Class_WordPress_AiClient_Providers_ApiBasedImplementation_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory.models_cache_key(),
		rt.new_closure(closure_1_fn), rt.new_int(86400))
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory) getcachedkeys() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_WordPress_AiClient_Providers_ApiBasedImplementation_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory.models_cache_key()
		},
	])
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory) getbasecachekey() string {
	return 'ai_client_' +(Class_WordPress_AiClient_AiClient.version()).str() + '_' +
		md5.hexhash(Class_WordPress_AiClient_Providers_ApiBasedImplementation_static.class().to_string())
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory) sendlistmodelsrequest() {
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_apibasedimplementation_abstractapibasedmodelmetadatadirectory() &Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory {
	mut obj := &Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory{
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

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'listModelMetadata' {
			return this.listmodelmetadata()
		}
		'hasModelMetadata' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.hasmodelmetadata(dispatch_arg_0))
		}
		'getModelMetadata' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.getmodelmetadata(dispatch_arg_0)
		}
		'getModelMetadataMap' {
			return this.getmodelmetadatamap()
		}
		'getCachedKeys' {
			return this.getcachedkeys()
		}
		'getBaseCacheKey' {
			return rt.new_string(this.getbasecachekey())
		}
		'sendListModelsRequest' {
			this.sendlistmodelsrequest()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_includes_php_ai_client_src_providers_apibasedimplementation_abstractapibasedmodelmetadatadirectory_php() {
	// unsupported statement: Stmt_Declare
}
