import rt

struct Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory {
	rt.PhpObjectBase
}

fn Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory.createtransporter() rt.PhpVal {
	return create_wordpress_aiclient_providers_http_wordpress_aiclient_providers_http_httptransporter(fn () rt.PhpVal {
		mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery{}
		return temp.find()
	}(), fn () rt.PhpVal {
		mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
		return temp.findrequestfactory()
	}(), fn () rt.PhpVal {
		mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
		return temp.findstreamfactory()
	}())
}

struct Class_WordPress_AiClient_Providers_Http_WordPress_AiClient_Providers_Http_HttpTransporter {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_http_httptransporterfactory() &Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory {
	mut obj := &Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_wordpress_aiclient_providers_http_httptransporter() &Class_WordPress_AiClient_Providers_Http_WordPress_AiClient_Providers_Http_HttpTransporter {
	mut obj := &Class_WordPress_AiClient_Providers_Http_WordPress_AiClient_Providers_Http_HttpTransporter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_psr18clientdiscovery() &Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_psr17factorydiscovery() &Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'createTransporter' {
			return Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory.createtransporter()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_WordPress_AiClient_Providers_Http_HttpTransporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_WordPress_AiClient_Providers_Http_HttpTransporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_WordPress_AiClient_Providers_Http_HttpTransporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_php_ai_client_src_providers_http_httptransporterfactory_php() {
	// unsupported statement: Stmt_Declare
}
