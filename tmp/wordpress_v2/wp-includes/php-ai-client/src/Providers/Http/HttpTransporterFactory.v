import rt

struct Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory {
	rt.PhpObjectBase
}

fn Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory.createtransporter() rt.PhpVal {
	mut iife_temp_0 := Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery{}
	mut iife_result_0 := iife_temp_0.find()
	mut iife_temp_1 := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
	mut iife_result_1 := iife_temp_1.findrequestfactory()
	mut iife_temp_2 := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}
	mut iife_result_2 := iife_temp_2.findstreamfactory()
	return rt.new_object('WordPress_AiClient_Providers_Http_WordPress_AiClient_Providers_Http_HttpTransporter',
		[]string{}, create_wordpress_aiclient_providers_http_wordpress_aiclient_providers_http_httptransporter(iife_result_0,
		iife_result_1, iife_result_2))
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

fn create_wordpress_aiclient_providers_http_httptransporterfactory(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory {
	mut obj := &Class_WordPress_AiClient_Providers_Http_HttpTransporterFactory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_wordpress_aiclient_providers_http_httptransporter(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_WordPress_AiClient_Providers_Http_HttpTransporter {
	mut obj := &Class_WordPress_AiClient_Providers_Http_WordPress_AiClient_Providers_Http_HttpTransporter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_psr18clientdiscovery(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_psr17factorydiscovery(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
