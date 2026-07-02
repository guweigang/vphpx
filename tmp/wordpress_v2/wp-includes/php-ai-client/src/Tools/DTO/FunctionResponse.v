import rt

pub fn Class_WordPress_AiClient_Tools_DTO_FunctionResponse.key_id() string {
	return 'id'
}
pub fn Class_WordPress_AiClient_Tools_DTO_FunctionResponse.key_name() string {
	return 'name'
}
pub fn Class_WordPress_AiClient_Tools_DTO_FunctionResponse.key_response() string {
	return 'response'
}
struct Class_WordPress_AiClient_Tools_DTO_FunctionResponse {
	rt.PhpObjectBase
pub mut:
		id rt.PhpVal = rt.new_null()
		name rt.PhpVal = rt.new_null()
		response rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionResponse) construct(mut var_id Class_WordPress_AiClient_Tools_DTO_?string, mut var_name Class_WordPress_AiClient_Tools_DTO_?string, var_response rt.PhpVal) {
	if rt.is_true(rt.identical(var_id, rt.new_null())) && rt.is_true(rt.identical(var_name, rt.new_null())) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('At least one of id or name must be provided.'))))
	}
	this.id = var_id
	this.name = var_name
	this.response = var_response.clone()
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionResponse) getid() string {
	return (this.id).str()
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionResponse) getname() string {
	return (this.name).str()
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionResponse) getresponse() rt.PhpVal {
	return this.response
}

fn Class_WordPress_AiClient_Tools_DTO_FunctionResponse.getjsonschema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionResponse.key_id(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'The ID of the function call this is responding to.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionResponse.key_name(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'The name of the function that was called.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionResponse.key_response(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'number' }, rt.ArrayItem{ key: none, val: 'boolean' }, rt.ArrayItem{ key: none, val: 'object' }, rt.ArrayItem{ key: none, val: 'array' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'description', val: 'The response data from the function.' }]) }]) }, rt.ArrayItem{ key: 'anyOf', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionResponse.key_response() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionResponse.key_id() }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionResponse.key_response() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionResponse.key_name() }]) }]) }]) }])
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionResponse) toarray() rt.PhpVal {
	mut var_data := rt.new_array()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.id, rt.new_null())))) {
		var_data.array_set(Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionResponse.key_id(), this.id)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.name, rt.new_null())))) {
		var_data.array_set(Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionResponse.key_name(), this.name)
	}
	var_data.array_set(Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionResponse.key_response(), this.response)
	return var_data.clone()
}

fn Class_WordPress_AiClient_Tools_DTO_FunctionResponse.fromarray(mut var_array Class_WordPress_AiClient_Tools_DTO_array) rt.PhpVal {
	mut iife_temp_0 := Class_WordPress_AiClient_Tools_DTO_FunctionResponse{}
	mut iife_result_0 := iife_temp_0.validatefromarraydata(rt.new_object('WordPress_AiClient_Tools_DTO_array', []string{}, var_array), rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionResponse.key_response() }]))
	return rt.new_object('WordPress_AiClient_Tools_DTO_self', []string{}, create_wordpress_aiclient_tools_dto_self(if !(var_array.array_get(Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionResponse.key_id())).is_null() { var_array.array_get(Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionResponse.key_id()) } else { rt.new_null() }, if !(var_array.array_get(Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionResponse.key_name())).is_null() { var_array.array_get(Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionResponse.key_name()) } else { rt.new_null() }, var_array.array_get(Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_FunctionResponse.key_response())))
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Tools_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_tools_dto_functionresponse(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WordPress_AiClient_Tools_DTO_FunctionResponse {
	mut obj := &Class_WordPress_AiClient_Tools_DTO_FunctionResponse{
		PhpObjectBase: rt.PhpObjectBase{}
		id: rt.new_null()
		name: rt.new_null()
		response: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
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

fn create_wordpress_aiclient_tools_dto_self(_args ...rt.PhpVal) &Class_WordPress_AiClient_Tools_DTO_self {
	mut obj := &Class_WordPress_AiClient_Tools_DTO_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionResponse) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'getId' {
			return rt.new_string(this.getid())
		}
		'getName' {
			return rt.new_string(this.getname())
		}
		'getResponse' {
			return this.getresponse()
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Tools_DTO_FunctionResponse.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Tools_DTO_FunctionResponse.fromarray(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Tools_DTO_FunctionResponse) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'name' { return this.name }
		'response' { return this.response }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionResponse) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' { this.id = val; return true }
		'name' { this.name = val; return true }
		'response' { this.response = val; return true }
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
