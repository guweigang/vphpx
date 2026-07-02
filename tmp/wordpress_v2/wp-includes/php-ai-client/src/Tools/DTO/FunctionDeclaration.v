import rt

pub fn Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration.key_name() string {
	return 'name'
}
pub fn Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration.key_description() string {
	return 'description'
}
pub fn Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration.key_parameters() string {
	return 'parameters'
}
struct Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration {
	rt.PhpObjectBase
pub mut:
		name string
		description string
		parameters rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration) construct(name string, description string, mut var_parameters Class_WordPress_AiClient_Tools_DTO_?array) {
	this.name = name
	this.description = description
	this.parameters = var_parameters
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration) getname() string {
	return this.name
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration) getdescription() string {
	return this.description
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration) getparameters() rt.PhpVal {
	return this.parameters
}

fn Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration.getjsonschema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionDeclaration.key_name(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'The name of the function.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionDeclaration.key_description(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'A description of what the function does.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionDeclaration.key_parameters(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'description', val: 'The JSON schema for the function parameters.' }, rt.ArrayItem{ key: 'additionalProperties', val: true }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionDeclaration.key_name() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionDeclaration.key_description() }]) }])
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration) toarray() rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionDeclaration.key_name(), val: this.name }, rt.ArrayItem{ key: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionDeclaration.key_description(), val: this.description }])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.parameters, rt.new_null())))) {
		var_data.array_set(Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionDeclaration.key_parameters(), this.parameters)
	}
	return var_data.clone()
}

fn Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration.fromarray(mut var_array Class_WordPress_AiClient_Tools_DTO_array) rt.PhpVal {
	mut iife_temp_0 := Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration{}
	mut iife_result_0 := iife_temp_0.validatefromarraydata(rt.new_object('WordPress_AiClient_Tools_DTO_array', []string{}, var_array), rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionDeclaration.key_name() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionDeclaration.key_description() }]))
	return rt.new_object('WordPress_AiClient_Tools_DTO_self', []string{}, create_wordpress_aiclient_tools_dto_self(var_array.array_get(Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionDeclaration.key_name()), var_array.array_get(Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionDeclaration.key_description()), if !(var_array.array_get(Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionDeclaration.key_parameters())).is_null() { var_array.array_get(Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionDeclaration.key_parameters()) } else { rt.new_null() }))
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Tools_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_tools_dto_functiondeclaration(name string, description string, arg_2 rt.PhpVal) &Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration {
	mut obj := &Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration{
		PhpObjectBase: rt.PhpObjectBase{}
		name: ''
		description: ''
		parameters: rt.new_null()
	}
	obj.construct(name, description, arg_2)
	return obj
}

fn create_wordpress_aiclient_common_abstractdatatransferobject(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	mut obj := &Class_WordPress_AiClient_Common_AbstractDataTransferObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_tools_dto_self(_args ...rt.PhpVal) &Class_WordPress_AiClient_Tools_DTO_self {
	mut obj := &Class_WordPress_AiClient_Tools_DTO_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_?array](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'getName' {
			return rt.new_string(this.getname())
		}
		'getDescription' {
			return rt.new_string(this.getdescription())
		}
		'getParameters' {
			return this.getparameters()
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration.fromarray(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return rt.new_string(this.name) }
		'description' { return rt.new_string(this.description) }
		'parameters' { return this.parameters }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' { this.name = (val).str(); return true }
		'description' { this.description = (val).str(); return true }
		'parameters' { this.parameters = val; return true }
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


fn (mut this Class_WordPress_AiClient_Tools_DTO_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Tools_DTO_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
