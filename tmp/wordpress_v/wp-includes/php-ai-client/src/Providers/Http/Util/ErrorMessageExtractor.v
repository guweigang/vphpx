import rt

struct Class_WordPress_AiClient_Providers_Http_Util_ErrorMessageExtractor {
	rt.PhpObjectBase
}

fn Class_WordPress_AiClient_Providers_Http_Util_ErrorMessageExtractor.extractfromresponsedata(var_data rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.dup().is_array()))))) {
		return (rt.new_null()).str()
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_data.array_isset(rt.new_int(0))
		&& rt.is_true(rt.new_bool(var_data.array_get(0).is_array()))))
		&& var_data.array_get(0).array_isset(rt.new_string('error'))))
		&& rt.is_true(rt.new_bool(var_data.array_get(0).array_get('error').is_array()))))
		&& var_data.array_get(0).array_get('error').array_isset(rt.new_string('message'))))
		&& rt.is_true(rt.new_bool(var_data.array_get(0).array_get('error').array_get('message').is_string()))))
	{
		return (var_data.array_get(0).array_get('error').array_get('message')).str()
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('error'))
		&& rt.is_true(rt.new_bool(var_data.array_get('error').is_array()))))
		&& var_data.array_get('error').array_isset(rt.new_string('message'))))
		&& rt.is_true(rt.new_bool(var_data.array_get('error').array_get('message').is_string()))))
	{
		return (var_data.array_get('error').array_get('message')).str()
	}
	if rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('error'))
		&& rt.is_true(rt.new_bool(var_data.array_get('error').is_string()))))
	{
		return (var_data.array_get('error')).str()
	}
	if rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('message'))
		&& rt.is_true(rt.new_bool(var_data.array_get('message').is_string()))))
	{
		return (var_data.array_get('message')).str()
	}
	return (rt.new_null()).str()
}

fn create_wordpress_aiclient_providers_http_util_errormessageextractor() &Class_WordPress_AiClient_Providers_Http_Util_ErrorMessageExtractor {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Util_ErrorMessageExtractor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Util_ErrorMessageExtractor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'extractFromResponseData' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WordPress_AiClient_Providers_Http_Util_ErrorMessageExtractor.extractfromresponsedata(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_Http_Util_ErrorMessageExtractor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Util_ErrorMessageExtractor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_php_ai_client_src_providers_http_util_errormessageextractor_php() {
	// unsupported statement: Stmt_Declare
}
