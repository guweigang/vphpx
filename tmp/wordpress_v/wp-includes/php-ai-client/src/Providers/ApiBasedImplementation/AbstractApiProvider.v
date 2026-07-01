import rt

struct Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiProvider {
	rt.PhpObjectBase
}

fn Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiProvider.baseurl() string {
	return ''
}

fn Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiProvider.url(path string) string {
	if rt.is_true(rt.identical(rt.new_string(path), rt.new_string(''))) {
		return (Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiProvider.baseurl()).str()
	}
	return
		(Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiProvider.baseurl()).str() +
		'/' + path.trim_left(' \t\n\r')
}

struct Class_WordPress_AiClient_Providers_AbstractProvider {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_apibasedimplementation_abstractapiprovider() &Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiProvider {
	mut obj := &Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_abstractprovider() &Class_WordPress_AiClient_Providers_AbstractProvider {
	mut obj := &Class_WordPress_AiClient_Providers_AbstractProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'baseUrl' {
			return rt.new_string(Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiProvider.baseurl())
		}
		'url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiProvider.url(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Providers_AbstractProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_AbstractProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_AbstractProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_php_ai_client_src_providers_apibasedimplementation_abstractapiprovider_php() {
	// unsupported statement: Stmt_Declare
}
