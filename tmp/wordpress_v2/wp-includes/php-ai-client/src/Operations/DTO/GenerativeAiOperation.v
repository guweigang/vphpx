import rt

pub fn Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_id() string {
	return 'id'
}
pub fn Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_state() string {
	return 'state'
}
pub fn Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_result() string {
	return 'result'
}
struct Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation {
	rt.PhpObjectBase
pub mut:
		id string
		state rt.PhpVal = rt.new_null()
		result rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation) construct(id string, mut var_state Class_WordPress_AiClient_Operations_Enums_OperationStateEnum, mut var_result Class_WordPress_AiClient_Operations_DTO_?GenerativeAiResult) {
	mut var_state_mutated := var_state
	mut var_result_mutated := var_result
	this.id = id
	this.state = var_state_mutated
	this.result = var_result_mutated
}

fn (mut this Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation) magic_clone() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.result, rt.new_null())))) {
		this.result = this.result.dup()
	}
}

fn (mut this Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation) getid() string {
	return this.id
}

fn (mut this Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation) getstate() rt.PhpVal {
	return this.state
}

fn (mut this Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation) getresult() rt.PhpVal {
	return this.result
}

fn Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.getjsonschema() rt.PhpVal {
	mut iife_temp_0 := Class_WordPress_AiClient_Operations_Enums_OperationStateEnum{}
	mut iife_result_0 := iife_temp_0.succeeded()
	mut iife_temp_1 := Class_WordPress_AiClient_Results_DTO_GenerativeAiResult{}
	mut iife_result_1 := iife_temp_1.getjsonschema()
	mut iife_temp_2 := Class_WordPress_AiClient_Operations_Enums_OperationStateEnum{}
	mut iife_result_2 := iife_temp_2.starting()
	mut iife_temp_3 := Class_WordPress_AiClient_Operations_Enums_OperationStateEnum{}
	mut iife_result_3 := iife_temp_3.processing()
	mut iife_temp_4 := Class_WordPress_AiClient_Operations_Enums_OperationStateEnum{}
	mut iife_result_4 := iife_temp_4.failed()
	mut iife_temp_5 := Class_WordPress_AiClient_Operations_Enums_OperationStateEnum{}
	mut iife_result_5 := iife_temp_5.canceled()
	return rt.create_array([rt.ArrayItem{ key: 'oneOf', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_id(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'Unique identifier for this operation.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_state(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'const', val: rt.get_property(iife_result_0, 'value') }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_result(), val: iife_result_1 }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_id() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_state() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_result() }]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_id(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'Unique identifier for this operation.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_state(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(iife_result_2, 'value') }, rt.ArrayItem{ key: none, val: rt.get_property(iife_result_3, 'value') }, rt.ArrayItem{ key: none, val: rt.get_property(iife_result_4, 'value') }, rt.ArrayItem{ key: none, val: rt.get_property(iife_result_5, 'value') }]) }, rt.ArrayItem{ key: 'description', val: 'The current state of the operation.' }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_id() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_state() }]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }]) }]) }])
}

fn (mut this Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation) toarray() rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_id(), val: this.id }, rt.ArrayItem{ key: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_state(), val: rt.get_property(this.state, 'value') }])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.result, rt.new_null())))) {
		var_data.array_set(Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_result(), rt.call_method(this.result, 'toArray', []rt.PhpVal{}))
	}
	return var_data.clone()
}

fn Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.fromarray(mut var_array Class_WordPress_AiClient_Operations_DTO_array) rt.PhpVal {
	mut iife_temp_6 := Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation{}
	mut iife_result_6 := iife_temp_6.validatefromarraydata(rt.new_object('WordPress_AiClient_Operations_DTO_array', []string{}, var_array), rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_id() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_state() }]))
	mut iife_temp_7 := Class_WordPress_AiClient_Operations_Enums_OperationStateEnum{}
	mut iife_result_7 := iife_temp_7.from(var_array.array_get(Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_state()))
	mut var_state := iife_result_7
	if rt.is_true(rt.call_method(var_state, 'isSucceeded', []rt.PhpVal{})) {
	mut iife_temp_8 := Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation{}
	mut iife_result_8 := iife_temp_8.validatefromarraydata(rt.new_object('WordPress_AiClient_Operations_DTO_array', []string{}, var_array), rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_result() }]))
	}
	mut var_result := rt.new_null()
	if var_array.array_isset(Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_result()) {
	mut iife_temp_9 := Class_WordPress_AiClient_Results_DTO_GenerativeAiResult{}
	mut iife_result_9 := iife_temp_9.fromarray(var_array.array_get(Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_result()))
	var_result = iife_result_9
	}
	return rt.new_object('WordPress_AiClient_Operations_DTO_self', []string{}, create_wordpress_aiclient_operations_dto_self(var_array.array_get(Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_id()), var_state.clone(), var_result.clone()))
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Operations_Enums_OperationStateEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Results_DTO_GenerativeAiResult {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Operations_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_operations_dto_generativeaioperation(id string, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation {
	mut obj := &Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation{
		PhpObjectBase: rt.PhpObjectBase{}
		id: ''
		state: rt.new_null()
		result: rt.new_null()
	}
	obj.construct(id, arg_1, arg_2)
	return obj
}

fn create_wordpress_aiclient_common_abstractdatatransferobject(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	mut obj := &Class_WordPress_AiClient_Common_AbstractDataTransferObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_operations_enums_operationstateenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Operations_Enums_OperationStateEnum {
	mut obj := &Class_WordPress_AiClient_Operations_Enums_OperationStateEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_results_dto_generativeairesult(_args ...rt.PhpVal) &Class_WordPress_AiClient_Results_DTO_GenerativeAiResult {
	mut obj := &Class_WordPress_AiClient_Results_DTO_GenerativeAiResult{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_operations_dto_self(_args ...rt.PhpVal) &Class_WordPress_AiClient_Operations_DTO_self {
	mut obj := &Class_WordPress_AiClient_Operations_DTO_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Operations_Enums_OperationStateEnum](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Operations_DTO_?GenerativeAiResult](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		'getId' {
			return rt.new_string(this.getid())
		}
		'getState' {
			return this.getstate()
		}
		'getResult' {
			return this.getresult()
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Operations_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.fromarray(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return rt.new_string(this.id) }
		'state' { return this.state }
		'result' { return this.result }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' { this.id = (val).str(); return true }
		'state' { this.state = val; return true }
		'result' { this.result = val; return true }
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


fn (mut this Class_WordPress_AiClient_Operations_Enums_OperationStateEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Operations_Enums_OperationStateEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Operations_Enums_OperationStateEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Operations_DTO_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Operations_DTO_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Operations_DTO_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
