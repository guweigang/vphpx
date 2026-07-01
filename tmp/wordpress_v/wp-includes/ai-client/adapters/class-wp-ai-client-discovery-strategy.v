import rt

struct Class_WP_AI_Client_Discovery_Strategy {
	rt.PhpObjectBase
}

fn Class_WP_AI_Client_Discovery_Strategy.createclient(mut var_psr17_factory Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory) rt.PhpVal {
	return create_wp_ai_client_http_client(var_psr17_factory.dup(), var_psr17_factory.dup())
}

struct Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy {
	rt.PhpObjectBase
}

struct Class_WP_AI_Client_HTTP_Client {
	rt.PhpObjectBase
}

fn create_wp_ai_client_discovery_strategy() &Class_WP_AI_Client_Discovery_Strategy {
	mut obj := &Class_WP_AI_Client_Discovery_Strategy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_abstracts_abstractclientdiscoverystrategy() &Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_ai_client_http_client() &Class_WP_AI_Client_HTTP_Client {
	mut obj := &Class_WP_AI_Client_HTTP_Client{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_AI_Client_Discovery_Strategy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'createClient' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_WP_AI_Client_Discovery_Strategy.createclient(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_AI_Client_Discovery_Strategy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.Class_AbstractClientDiscoveryStrategy.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_AI_Client_Discovery_Strategy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.Class_AbstractClientDiscoveryStrategy.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_AI_Client_HTTP_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_AI_Client_HTTP_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_AI_Client_HTTP_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_ai_client_adapters_class_wp_ai_client_discovery_strategy_php() {
}
