import rt

pub fn Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption.key_name() string {
	return 'name'
}
pub fn Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption.key_supported_values() string {
	return 'supportedValues'
}
struct Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption {
	rt.PhpObjectBase
pub mut:
		name rt.PhpVal = rt.new_null()
		supportedValues rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption) construct(mut var_name Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum, mut var_supportedValues Class_WordPress_AiClient_Providers_Models_DTO_?array)  {
	mut var_supportedValues_mutated := var_supportedValues
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_is_list', [var_supportedValues_mutated.dup()]))))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Supported values must be a list array.'))))
	}
	this.name = var_name.dup()
	this.supportedValues = var_supportedValues_mutated.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption) getname() rt.PhpVal {
	return this.name
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption) issupportedvalue(var_value rt.PhpVal) bool {
	if rt.is_true(rt.identical(this.supportedValues, rt.new_null())) {
		return true
	}
	if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
		mut var_normalizedValue := Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption.normalizearrayforcomparison(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](var_value))
		{
			mut iter_1 := this.supportedValues.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_supportedValue := item_1.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_supportedValue.dup().is_array()))))) {
					continue
				}
				mut var_normalizedSupported := Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption.normalizearrayforcomparison(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](var_supportedValue))
				if rt.is_true(rt.identical(var_normalizedValue, var_normalizedSupported)) {
					return true
				}
			}
		}
		return false
	}
	var_normalizedValue = Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption.normalizevalue(var_value.dup())
	{
		mut iter_1 := this.supportedValues.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_supportedValue := item_1.val
			if rt.is_true(rt.identical(Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption.normalizevalue(var_supportedValue.dup()), var_normalizedValue)) {
				return true
			}
		}
	}
	return false
}

fn Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption.normalizevalue(var_value rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(var_value, 'WordPress_AiClient_Common_AbstractEnum'))) {
		return rt.get_property(var_value, 'value')
	}
	return var_value.dup()
}

fn Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption.normalizearrayforcomparison(mut var_items Class_WordPress_AiClient_Providers_Models_DTO_array) rt.PhpVal {
	mut var_normalized := rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption.class() }, rt.ArrayItem{ key: none, val: 'normalizeValue' }]), var_items])
	rt.call_function('sort', [var_normalized.dup()])
	return var_normalized.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption) getsupportedvalues() rt.PhpVal {
	return this.supportedValues
}

fn Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption.getjsonschema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption.key_name(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.getvalues() }() }, rt.ArrayItem{ key: 'description', val: 'The option name.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption.key_supported_values(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'oneOf', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'number' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'null' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }]) }]) }]) }, rt.ArrayItem{ key: 'description', val: 'The supported values for this option.' }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption.key_name() }]) }])
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption) toarray() rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption.key_name(), val: rt.get_property(this.name, 'value') }])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_supportedValues := this.supportedValues
		var_data.array_set(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption.key_supported_values(), var_supportedValues.dup())
	}
	return var_data.dup()
}

fn Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption.fromarray(mut var_array Class_WordPress_AiClient_Providers_Models_DTO_array) rt.PhpVal {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption{}; return temp.validatefromarraydata(arg_0, arg_1) }(rt.new_object('WordPress_AiClient_Providers_Models_DTO_array', []string{}, var_array), rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption.key_name() }]))
	return create_wordpress_aiclient_providers_models_dto_self(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{}; return temp.from(arg_0) }(var_array.array_get(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption.key_name())), if !(var_array.array_get(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption.key_supported_values())).is_null() { var_array.array_get(Class_WordPress_AiClient_Providers_Models_DTO_WordPress_AiClient_Providers_Models_DTO_SupportedOption.key_supported_values()) } else { rt.new_null() })
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Models_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_models_dto_supportedoption(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption{
		PhpObjectBase: rt.PhpObjectBase{}
		name: rt.new_null()
		supportedValues: rt.new_null()
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

fn create_wordpress_aiclient_providers_models_enums_optionenum() &Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum {
	mut obj := &Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_models_dto_self() &Class_WordPress_AiClient_Providers_Models_DTO_self {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'getName' {
			return this.getname()
		}
		'isSupportedValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.issupportedvalue(dispatch_arg_0))
		}
		'normalizeValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption.normalizevalue(dispatch_arg_0)
		}
		'normalizeArrayForComparison' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption.normalizearrayforcomparison(mut dispatch_arg_0)
		}
		'getSupportedValues' {
			return this.getsupportedvalues()
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption.fromarray(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'supportedValues' { return this.supportedValues }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_SupportedOption) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' { this.name = val; return true }
		'supportedValues' { this.supportedValues = val; return true }
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




pub fn init_wp_includes_php_ai_client_src_providers_models_dto_supportedoption_php() {
	// unsupported statement: Stmt_Declare
}
