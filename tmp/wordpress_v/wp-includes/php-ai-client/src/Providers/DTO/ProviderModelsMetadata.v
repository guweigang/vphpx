import rt

pub fn Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata.key_provider() string {
	return 'provider'
}
pub fn Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata.key_models() string {
	return 'models'
}
struct Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata {
	rt.PhpObjectBase
pub mut:
		provider rt.PhpVal = rt.new_null()
		models rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata) construct(mut var_provider Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata, mut var_models Class_WordPress_AiClient_Providers_DTO_array)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_is_list', [var_models]))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Models must be a list array.'))))
	}
	this.provider = var_provider.dup()
	this.models = var_models.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata) magic_clone()  {
	this.provider = // unsupported expression: Expr_Clone
	mut var_clonedModels := rt.new_array()
	{
		mut iter_1 := this.models.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_model := item_1.val
			var_clonedModels.array_push(// unsupported expression: Expr_Clone)
		}
	}
	this.models = var_clonedModels.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata) getprovider() rt.PhpVal {
	return this.provider
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata) getmodels() rt.PhpVal {
	return this.models
}

fn Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata.getjsonschema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata.key_provider(), val: fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata{}; return temp.getjsonschema() }() }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata.key_models(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata{}; return temp.getjsonschema() }() }, rt.ArrayItem{ key: 'description', val: 'The available models for this provider.' }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata.key_provider() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata.key_models() }]) }])
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata) toarray() rt.PhpVal {
	mut var_model := rt.new_null()
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_model := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_model, 'toArray', []rt.PhpVal{})
	}
	mut var_model := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_model, 'toArray', []rt.PhpVal{})
	}
	return rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata.key_provider(), val: rt.call_method(this.provider, 'toArray', []rt.PhpVal{}) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata.key_models(), val: rt.call_function('array_map', [rt.new_closure(closure_1_fn), this.models]) }])
}

fn Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata.fromarray(mut var_array Class_WordPress_AiClient_Providers_DTO_array) rt.PhpVal {
	mut var_modelData := rt.new_null()
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata{}; return temp.validatefromarraydata(arg_0, arg_1) }(rt.new_object('WordPress_AiClient_Providers_DTO_array', []string{}, var_array), rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata.key_provider() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata.key_models() }]))
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_modelData := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata{}; return temp.fromarray(arg_0) }(var_modelData.dup())
	}
	mut var_modelData := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata{}; return temp.fromarray(arg_0) }(var_modelData.dup())
	}
	return create_wordpress_aiclient_providers_dto_self(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata{}; return temp.fromarray(arg_0) }(var_array.array_get(Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata.key_provider())), rt.call_function('array_map', [rt.new_closure(closure_3_fn), var_array.array_get(Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata.key_models())]))
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_dto_providermodelsmetadata(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata {
	mut obj := &Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata{
		PhpObjectBase: rt.PhpObjectBase{}
		provider: rt.new_null()
		models: rt.new_null()
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

fn create_wordpress_aiclient_providers_dto_wordpress_aiclient_providers_dto_providermetadata() &Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata {
	mut obj := &Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_models_dto_modelmetadata() &Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_dto_self() &Class_WordPress_AiClient_Providers_DTO_self {
	mut obj := &Class_WordPress_AiClient_Providers_DTO_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_DTO_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		'getProvider' {
			return this.getprovider()
		}
		'getModels' {
			return this.getmodels()
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata.fromarray(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'provider' { return this.provider }
		'models' { return this.models }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderModelsMetadata) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'provider' { this.provider = val; return true }
		'models' { this.models = val; return true }
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


fn (mut this Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_DTO_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_DTO_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_php_ai_client_src_providers_dto_providermodelsmetadata_php() {
	// unsupported statement: Stmt_Declare
}
