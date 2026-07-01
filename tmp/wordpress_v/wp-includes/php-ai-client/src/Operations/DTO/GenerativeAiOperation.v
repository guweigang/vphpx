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

fn (mut this Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation) construct(id string, mut var_state Class_WordPress_AiClient_Operations_Enums_OperationStateEnum, mut var_result Class_WordPress_AiClient_Operations_DTO_?GenerativeAiResult)  {
	mut var_state_mutated := var_state
	mut var_result_mutated := var_result
	this.id = id
	this.state = var_state_mutated.dup()
	this.result = var_result_mutated.dup()
}

fn (mut this Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation) magic_clone()  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.result = // unsupported expression: Expr_Clone
	}
	// unsupported statement: Stmt_Nop
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
	return rt.create_array([rt.ArrayItem{ key: 'oneOf', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_id(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'Unique identifier for this operation.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_state(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'const', val: rt.get_property(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Operations_Enums_OperationStateEnum{}; return temp.succeeded() }(), 'value') }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_result(), val: fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Results_DTO_GenerativeAiResult{}; return temp.getjsonschema() }() }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_id() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_state() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_result() }]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_id(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'Unique identifier for this operation.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_state(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Operations_Enums_OperationStateEnum{}; return temp.starting() }(), 'value') }, rt.ArrayItem{ key: none, val: rt.get_property(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Operations_Enums_OperationStateEnum{}; return temp.processing() }(), 'value') }, rt.ArrayItem{ key: none, val: rt.get_property(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Operations_Enums_OperationStateEnum{}; return temp.failed() }(), 'value') }, rt.ArrayItem{ key: none, val: rt.get_property(fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Operations_Enums_OperationStateEnum{}; return temp.canceled() }(), 'value') }]) }, rt.ArrayItem{ key: 'description', val: 'The current state of the operation.' }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_id() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_state() }]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }]) }]) }])
}

fn (mut this Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation) toarray() rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_id(), val: this.id }, rt.ArrayItem{ key: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_state(), val: rt.get_property(this.state, 'value') }])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_result(), rt.call_method(this.result, 'toArray', []rt.PhpVal{}))
	}
	return var_data.dup()
}

fn Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.fromarray(mut var_array Class_WordPress_AiClient_Operations_DTO_array) rt.PhpVal {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation{}; return temp.validatefromarraydata(arg_0, arg_1) }(rt.new_object('WordPress_AiClient_Operations_DTO_array', []string{}, var_array), rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_id() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_state() }]))
	mut var_state := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Operations_Enums_OperationStateEnum{}; return temp.from(arg_0) }(var_array.array_get(Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_state()))
	if rt.is_true(rt.call_method(var_state, 'isSucceeded', []rt.PhpVal{})) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Operations_DTO_GenerativeAiOperation{}; return temp.validatefromarraydata(arg_0, arg_1) }(rt.new_object('WordPress_AiClient_Operations_DTO_array', []string{}, var_array), rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_result() }]))
	}
	mut var_result := rt.new_null()
	if var_array.array_isset(Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_result()) {
		var_result = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Results_DTO_GenerativeAiResult{}; return temp.fromarray(arg_0) }(var_array.array_get(Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_result()))
	}
	return create_wordpress_aiclient_operations_dto_self(var_array.array_get(Class_WordPress_AiClient_Operations_DTO_WordPress_AiClient_Operations_DTO_GenerativeAiOperation.key_id()), var_state.dup(), var_result.dup())
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

fn create_wordpress_aiclient_common_abstractdatatransferobject() &Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	mut obj := &Class_WordPress_AiClient_Common_AbstractDataTransferObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_operations_enums_operationstateenum() &Class_WordPress_AiClient_Operations_Enums_OperationStateEnum {
	mut obj := &Class_WordPress_AiClient_Operations_Enums_OperationStateEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_results_dto_generativeairesult() &Class_WordPress_AiClient_Results_DTO_GenerativeAiResult {
	mut obj := &Class_WordPress_AiClient_Results_DTO_GenerativeAiResult{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_operations_dto_self() &Class_WordPress_AiClient_Operations_DTO_self {
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




pub fn init_wp_includes_php_ai_client_src_operations_dto_generativeaioperation_php() {
	// unsupported statement: Stmt_Declare
}
