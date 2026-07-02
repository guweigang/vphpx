import rt

fn wp_supports_ai() bool {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_AI_SUPPORT')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_AI_SUPPORT'))))) {
		return false
	}
	return (rt.call_function('apply_filters', [rt.new_string('wp_supports_ai'),
		rt.new_bool(true)])).to_bool()
}

fn wp_ai_client_prompt(var_prompt rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_WordPress_AiClient_AiClient{}
	mut iife_result_0 := iife_temp_0.defaultregistry()
	return rt.new_object('WP_AI_Client_Prompt_Builder', []string{}, create_wp_ai_client_prompt_builder(iife_result_0,
		var_prompt.clone()))
}

struct Class_WP_AI_Client_Prompt_Builder {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_AiClient {
	rt.PhpObjectBase
}

fn create_wp_ai_client_prompt_builder(_args ...rt.PhpVal) &Class_WP_AI_Client_Prompt_Builder {
	mut obj := &Class_WP_AI_Client_Prompt_Builder{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_aiclient(_args ...rt.PhpVal) &Class_WordPress_AiClient_AiClient {
	mut obj := &Class_WordPress_AiClient_AiClient{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_AI_Client_Prompt_Builder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_AI_Client_Prompt_Builder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_AI_Client_Prompt_Builder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_AiClient) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_AiClient) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_AiClient) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
