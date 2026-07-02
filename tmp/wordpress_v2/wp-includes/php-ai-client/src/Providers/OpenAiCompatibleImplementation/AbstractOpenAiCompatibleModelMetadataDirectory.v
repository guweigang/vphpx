import rt

struct Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleModelMetadataDirectory {
	rt.PhpObjectBase
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleModelMetadataDirectory) sendlistmodelsrequest() rt.PhpVal {
	mut var_httpTransporter := this.gethttptransporter()
	mut iife_temp_0 := Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum{}
	mut iife_result_0 := iife_temp_0.get()
	mut var_request := this.createrequest(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum](iife_result_0),
		'models', rt.new_null(), rt.new_null())
	var_request = rt.call_method(this.getrequestauthentication(), 'authenticateRequest', [
		var_request.clone(),
	])
	mut var_response := rt.call_method(var_httpTransporter, 'send', [
		var_request.clone()])
	this.throwifnotsuccessful(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_Response](var_response))
	mut var_modelsMetadataList :=
		this.parseresponsetomodelmetadatalist(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_Response](var_response))
	mut var_modelMetadataMap := rt.new_array()
	mut iter_1 := var_modelsMetadataList.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_modelMetadata := item_1.val
		var_modelMetadataMap.array_set(rt.call_method(var_modelMetadata, 'getId', []rt.PhpVal{}),
			var_modelMetadata.clone())
	}
	return var_modelMetadataMap.clone()
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleModelMetadataDirectory) createrequest(mut var_method Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum, path string, mut var_headers Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array, var_data rt.PhpVal) {
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleModelMetadataDirectory) throwifnotsuccessful(mut var_response Class_WordPress_AiClient_Providers_Http_DTO_Response) {
	mut var_response_mutated := var_response
	mut iife_temp_1 := Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil{}
	mut iife_result_1 := iife_temp_1.throwifnotsuccessful(rt.new_object('WordPress_AiClient_Providers_Http_DTO_Response',
		[]string{}, var_response_mutated))
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleModelMetadataDirectory) parseresponsetomodelmetadatalist(mut var_response Class_WordPress_AiClient_Providers_Http_DTO_Response) {
	mut var_response_mutated := var_response
}

struct Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_openaicompatibleimplementation_abstractopenaicompatiblemodelmetadatadirectory(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleModelMetadataDirectory {
	mut obj := &Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleModelMetadataDirectory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_apibasedimplementation_abstractapibasedmodelmetadatadirectory(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory {
	mut obj := &Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_enums_httpmethodenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_util_responseutil(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleModelMetadataDirectory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'sendListModelsRequest' {
			return this.sendlistmodelsrequest()
		}
		'createRequest' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.createrequest(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2,
				dispatch_arg_3)
			return rt.new_null()
		}
		'throwIfNotSuccessful' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_Response](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.throwifnotsuccessful(mut dispatch_arg_0)
			return rt.new_null()
		}
		'parseResponseToModelMetadataList' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_Response](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.parseresponsetomodelmetadatalist(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleModelMetadataDirectory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleModelMetadataDirectory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModelMetadataDirectory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
