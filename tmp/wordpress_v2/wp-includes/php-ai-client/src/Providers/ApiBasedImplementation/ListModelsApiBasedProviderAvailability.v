import rt

struct Class_WordPress_AiClient_Providers_ApiBasedImplementation_ListModelsApiBasedProviderAvailability {
	rt.PhpObjectBase
pub mut:
	modelMetadataDirectory rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_ListModelsApiBasedProviderAvailability) construct(mut var_modelMetadataDirectory Class_WordPress_AiClient_Providers_Contracts_ModelMetadataDirectoryInterface) {
	this.modelMetadataDirectory = var_modelMetadataDirectory
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_ListModelsApiBasedProviderAvailability) isconfigured() bool {
	rt.call_method(this.modelMetadataDirectory, 'listModelMetadata', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return true
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		return false
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return false
}

fn create_wordpress_aiclient_providers_apibasedimplementation_listmodelsapibasedprovideravailability(arg_0 rt.PhpVal) &Class_WordPress_AiClient_Providers_ApiBasedImplementation_ListModelsApiBasedProviderAvailability {
	mut obj := &Class_WordPress_AiClient_Providers_ApiBasedImplementation_ListModelsApiBasedProviderAvailability{
		PhpObjectBase:          rt.PhpObjectBase{}
		modelMetadataDirectory: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_ListModelsApiBasedProviderAvailability) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Contracts_ModelMetadataDirectoryInterface](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'isConfigured' {
			return rt.new_bool(this.isconfigured())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_ApiBasedImplementation_ListModelsApiBasedProviderAvailability) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'modelMetadataDirectory' { return this.modelMetadataDirectory }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_ListModelsApiBasedProviderAvailability) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'modelMetadataDirectory' {
			this.modelMetadataDirectory = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
