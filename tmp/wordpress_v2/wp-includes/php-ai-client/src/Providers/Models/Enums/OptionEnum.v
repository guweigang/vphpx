import rt

pub fn Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum.input_modalities() string {
	return 'input_modalities'
}

struct Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum {
	rt.PhpObjectBase
}

fn Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum.determineclassenumerations(className string) rt.PhpVal {
	mut var_constants :=
		this.Class_WordPress_AiClient_Common_AbstractEnum.determineclassenumerations(rt.new_string(className))
	mut var_modelConfigReflection :=
		create_reflectionclass(Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.class())
	mut var_modelConfigConstants := var_modelConfigReflection.getconstants()
	mut iter_1 := var_modelConfigConstants.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_constantValue := item_1.val
		mut var_constantName := item_1.key
		if rt.is_true(rt.call_function('str_starts_with', [var_constantName.clone(),
			rt.new_string('KEY_')]))
		{
			mut var_enumConstantName := rt.call_function('substr', [
				var_constantName.clone(), rt.new_int(4)])
			if rt.is_true(rt.new_bool(var_constantValue.clone().is_string())) {
				var_constants.array_set(var_enumConstantName, var_constantValue.clone())
			}
		}
	}
	return var_constants.clone()
}

struct Class_WordPress_AiClient_Common_AbstractEnum {
	rt.PhpObjectBase
}

struct Class_ReflectionClass {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_models_enums_optionenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum {
	mut obj := &Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_common_abstractenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_AbstractEnum {
	mut obj := &Class_WordPress_AiClient_Common_AbstractEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_reflectionclass(_args ...rt.PhpVal) &Class_ReflectionClass {
	mut obj := &Class_ReflectionClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'determineClassEnumerations' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum.determineclassenumerations(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Models_Enums_OptionEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Common_AbstractEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_AbstractEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_AbstractEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ReflectionClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ReflectionClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ReflectionClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
