import rt

pub fn Class_WordPress_AiClient_Operations_Enums_OperationStateEnum.starting() string {
	return 'starting'
}

pub fn Class_WordPress_AiClient_Operations_Enums_OperationStateEnum.processing() string {
	return 'processing'
}

pub fn Class_WordPress_AiClient_Operations_Enums_OperationStateEnum.succeeded() string {
	return 'succeeded'
}

pub fn Class_WordPress_AiClient_Operations_Enums_OperationStateEnum.failed() string {
	return 'failed'
}

pub fn Class_WordPress_AiClient_Operations_Enums_OperationStateEnum.canceled() string {
	return 'canceled'
}

struct Class_WordPress_AiClient_Operations_Enums_OperationStateEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_AbstractEnum {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_operations_enums_operationstateenum() &Class_WordPress_AiClient_Operations_Enums_OperationStateEnum {
	mut obj := &Class_WordPress_AiClient_Operations_Enums_OperationStateEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_common_abstractenum() &Class_WordPress_AiClient_Common_AbstractEnum {
	mut obj := &Class_WordPress_AiClient_Common_AbstractEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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

fn (mut this Class_WordPress_AiClient_Common_AbstractEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_AbstractEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_AbstractEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_php_ai_client_src_operations_enums_operationstateenum_php() {
	// unsupported statement: Stmt_Declare
}
