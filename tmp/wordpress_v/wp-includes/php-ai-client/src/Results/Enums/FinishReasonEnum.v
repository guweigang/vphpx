import rt

pub fn Class_WordPress_AiClient_Results_Enums_FinishReasonEnum.stop() string {
	return 'stop'
}

pub fn Class_WordPress_AiClient_Results_Enums_FinishReasonEnum.length() string {
	return 'length'
}

pub fn Class_WordPress_AiClient_Results_Enums_FinishReasonEnum.content_filter() string {
	return 'content_filter'
}

pub fn Class_WordPress_AiClient_Results_Enums_FinishReasonEnum.tool_calls() string {
	return 'tool_calls'
}

pub fn Class_WordPress_AiClient_Results_Enums_FinishReasonEnum.error() string {
	return 'error'
}

struct Class_WordPress_AiClient_Results_Enums_FinishReasonEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_AbstractEnum {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_results_enums_finishreasonenum() &Class_WordPress_AiClient_Results_Enums_FinishReasonEnum {
	mut obj := &Class_WordPress_AiClient_Results_Enums_FinishReasonEnum{
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

fn (mut this Class_WordPress_AiClient_Results_Enums_FinishReasonEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Results_Enums_FinishReasonEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Results_Enums_FinishReasonEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_includes_php_ai_client_src_results_enums_finishreasonenum_php() {
	// unsupported statement: Stmt_Declare
}
