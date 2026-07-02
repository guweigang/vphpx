import rt

pub fn Class_WordPress_AiClient_Providers_Models_DTO_RequiredOption.key_name() string {
	return 'name'
}

pub fn Class_WordPress_AiClient_Providers_Models_DTO_RequiredOption.key_value() string {
	return 'value'
}

struct Class_WordPress_AiClient_Providers_Models_DTO_RequiredOption {
	rt.PhpObjectBase
pub mut:
	name  rt.PhpVal = rt.new_null()
	value rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_RequiredOption) construct(mut var_name Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum, var_value rt.PhpVal) {
	this.name = var_name
	this.value = var_value.clone()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_RequiredOption) getname() rt.PhpVal {
	return this.name
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_RequiredOption) getvalue() rt.PhpVal {
	return this.value
}

fn Class_WordPress_AiClient_Providers_Models_DTO_RequiredOption.getjsonschema() rt.PhpVal {
	mut iife_temp_0 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
	mut iife_result_0 := iife_temp_0.getvalues()
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{
				key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption.key_name()
				val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: iife_result_0 },
					rt.ArrayItem{ key: 'description', val: 'The option name.' }])
			},
			rt.ArrayItem{
				key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption.key_value()
				val: rt.create_array([rt.ArrayItem{ key: 'oneOf', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'number' },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'boolean' },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'null' },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'array' },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
					]) },
				]) }, rt.ArrayItem{
					key: 'description'
					val: 'The value that the model must support for this option.'
				}])
			},
		]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption.key_name()
			},
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption.key_value()
			},
		]) }])
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_RequiredOption) toarray() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption.key_name()
			val: rt.get_property(this.name, 'value')
		},
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption.key_value()
			val: this.value
		},
	])
}

fn Class_WordPress_AiClient_Providers_Models_DTO_RequiredOption.fromarray(mut var_array Class_WordPress_AiClient_Providers_Models_DTO_array) rt.PhpVal {
	mut iife_temp_1 := Class_WordPress_AiClient_Providers_Models_DTO_RequiredOption{}
	mut iife_result_1 := iife_temp_1.validatefromarraydata(rt.new_object('WordPress_AiClient_Providers_Models_DTO_array',
		[]string{}, var_array), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption.key_name()
		},
		rt.ArrayItem{
			key: none
			val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption.key_value()
		},
	]))
	mut iife_temp_2 := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}
	mut iife_result_2 :=
		iife_temp_2.from(var_array.array_get(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption.key_name()))
	return rt.new_object('WordPress_AiClient_Providers_Models_DTO_self', []string{}, create_wordpress_aiclient_providers_models_dto_self(iife_result_2,
		var_array.array_get(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_RequiredOption.key_value())))
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Models_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_models_dto_requiredoption(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WordPress_AiClient_Providers_Models_DTO_RequiredOption {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_RequiredOption{
		PhpObjectBase: rt.PhpObjectBase{}
		name:          rt.new_null()
		value:         rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_wordpress_aiclient_common_abstractdatatransferobject(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	mut obj := &Class_WordPress_AiClient_Common_AbstractDataTransferObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_models_enums_optionenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum {
	mut obj := &Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{
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

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_RequiredOption) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'getName' {
			return this.getname()
		}
		'getValue' {
			return this.getvalue()
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Providers_Models_DTO_RequiredOption.getjsonschema()
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
			return Class_WordPress_AiClient_Providers_Models_DTO_RequiredOption.fromarray(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_Models_DTO_RequiredOption) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'value' { return this.value }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_RequiredOption) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		'value' {
			this.value = val
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

fn (mut this Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
