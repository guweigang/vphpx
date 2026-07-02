import rt

pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_id() string {
	return 'id'
}

pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_name() string {
	return 'name'
}

pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_supported_capabilities() string {
	return 'supportedCapabilities'
}

pub fn Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_supported_options() string {
	return 'supportedOptions'
}

struct Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata {
	rt.PhpObjectBase
pub mut:
	id                    string
	name                  string
	supportedCapabilities rt.PhpVal = rt.new_null()
	supportedOptions      rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata) construct(id string, name string, mut var_supportedCapabilities Class_WordPress_AiClient_Providers_Models_DTO_array, mut var_supportedOptions Class_WordPress_AiClient_Providers_Models_DTO_array) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_is_list', [
		var_supportedCapabilities,
	])))))
	{
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException',
			[]string{},
			create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Supported capabilities must be a list array.'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_is_list', [
		var_supportedOptions,
	])))))
	{
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException',
			[]string{},
			create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Supported options must be a list array.'))))
	}
	this.id = id
	this.name = name
	this.supportedCapabilities = var_supportedCapabilities
	this.supportedOptions = var_supportedOptions
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata) getid() string {
	return this.id
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata) getname() string {
	return this.name
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata) getsupportedcapabilities() rt.PhpVal {
	return this.supportedCapabilities
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata) getsupportedoptions() rt.PhpVal {
	return this.supportedOptions
}

fn Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.getjsonschema() rt.PhpVal {
	mut iife_temp_0 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
	mut iife_result_0 := iife_temp_0.getvalues()
	mut iife_temp_1 :=
		Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption{}
	mut iife_result_1 := iife_temp_1.getjsonschema()
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{
				key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_id()
				val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'description', val: "The model's unique identifier." }])
			},
			rt.ArrayItem{
				key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_name()
				val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'description', val: "The model's display name." }])
			},
			rt.ArrayItem{
				key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_supported_capabilities()
				val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'items', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'enum', val: iife_result_0 },
					]) }, rt.ArrayItem{
						key: 'description'
						val: "The model's supported capabilities."
					}])
			},
			rt.ArrayItem{
				key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_supported_options()
				val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'items', val: iife_result_1 },
					rt.ArrayItem{
						key: 'description'
						val: "The model's supported configuration options."
					}])
			},
		]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_id()
			},
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_name()
			},
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_supported_capabilities()
			},
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_supported_options()
			},
		]) }])
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata) toarray() rt.PhpVal {
	mut var_capability := rt.new_null()
	mut var_option := rt.new_null()
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_capability := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.get_property(var_capability, 'value')
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_capability := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.get_property(var_capability, 'value')
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_option := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_option, 'toArray', []rt.PhpVal{})
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_option := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_option, 'toArray', []rt.PhpVal{})
	}
	return rt.create_array([
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_id()
			val: this.id
		},
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_name()
			val: this.name
		},
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_supported_capabilities()
			val: rt.call_function('array_map',
				[rt.new_closure(closure_3_fn), this.supportedCapabilities])
		},
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_supported_options()
			val: rt.call_function('array_map',
				[rt.new_closure(closure_5_fn), this.supportedOptions])
		},
	])
}

fn Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.fromarray(mut var_array Class_WordPress_AiClient_Providers_Models_DTO_array) rt.PhpVal {
	mut var_capability := rt.new_null()
	mut var_optionData := rt.new_null()
	mut iife_temp_6 := Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata{}
	mut iife_result_6 := iife_temp_6.validatefromarraydata(rt.new_object('WordPress_AiClient_Providers_Models_DTO_array',
		[]string{}, var_array), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_id()
		},
		rt.ArrayItem{
			key: none
			val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_name()
		},
		rt.ArrayItem{
			key: none
			val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_supported_capabilities()
		},
		rt.ArrayItem{
			key: none
			val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_supported_options()
		},
	]))
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_capability := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_8 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
		mut iife_result_8 := iife_temp_8.from(var_capability.clone())
		return iife_result_8
	}
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_capability := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_10 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
		mut iife_result_10 := iife_temp_10.from(var_capability.clone())
		return iife_result_10
	}
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_optionData := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_12 :=
			Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption{}
		mut iife_result_12 := iife_temp_12.fromarray(var_optionData.clone())
		return iife_result_12
	}
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_optionData := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_14 :=
			Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption{}
		mut iife_result_14 := iife_temp_14.fromarray(var_optionData.clone())
		return iife_result_14
	}
	return rt.new_object('WordPress_AiClient_Providers_Models_DTO_self', []string{}, create_wordpress_aiclient_providers_models_dto_self(var_array.array_get(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_id()),
		var_array.array_get(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_name()), rt.call_function('array_map', [
		rt.new_closure(closure_9_fn),
		var_array.array_get(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_supported_capabilities()),
	]), rt.call_function('array_map', [rt.new_closure(closure_13_fn),
		var_array.array_get(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.key_supported_options())])))
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata) magic_clone() {
	mut var_clonedOptions := rt.new_array()
	mut iter_1 := this.supportedOptions.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_option := item_1.val
		var_clonedOptions.array_push(var_option.dup())
	}
	this.supportedOptions = var_clonedOptions.clone()
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

struct Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Models_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_models_dto_modelmetadata(id string, name string, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata{
		PhpObjectBase:         rt.PhpObjectBase{}
		id:                    ''
		name:                  ''
		supportedCapabilities: rt.new_null()
		supportedOptions:      rt.new_null()
	}
	obj.construct(id, name, arg_2, arg_3)
	return obj
}

fn create_wordpress_aiclient_common_abstractdatatransferobject(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	mut obj := &Class_WordPress_AiClient_Common_AbstractDataTransferObject{
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

fn create_wordpress_aiclient_providers_models_enums_capabilityenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum {
	mut obj := &Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_models_dto_wordpress_aiclient_providers_models_dto_supportedoption(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_models_dto_self(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Models_DTO_self {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			this.construct(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'getId' {
			return rt.new_string(this.getid())
		}
		'getName' {
			return rt.new_string(this.getname())
		}
		'getSupportedCapabilities' {
			return this.getsupportedcapabilities()
		}
		'getSupportedOptions' {
			return this.getsupportedoptions()
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata.fromarray(mut dispatch_arg_0)
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return rt.new_string(this.id) }
		'name' { return rt.new_string(this.name) }
		'supportedCapabilities' { return this.supportedCapabilities }
		'supportedOptions' { return this.supportedOptions }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelMetadata) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val.str()
			return true
		}
		'name' {
			this.name = val.str()
			return true
		}
		'supportedCapabilities' {
			this.supportedCapabilities = val
			return true
		}
		'supportedOptions' {
			this.supportedOptions = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
