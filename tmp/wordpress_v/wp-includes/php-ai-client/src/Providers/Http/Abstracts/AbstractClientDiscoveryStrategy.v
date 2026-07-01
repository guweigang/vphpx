import rt

struct Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy {
	rt.PhpObjectBase
}

fn Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy.init() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WordPress\\AiClientDependencies\\Http\\Discovery\\Psr18ClientDiscovery'),
	])))))
	{
		return rt.new_null()
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery{}
		return temp.prependstrategy(arg_0)
	}(Class_WordPress_AiClient_Providers_Http_Abstracts_static.class())
}

fn Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy.getcandidates(var_type rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(Class_WordPress_AiClientDependencies_Psr_Http_Client_ClientInterface.class(),
		var_type))
	{
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_psr17Factory :=
				create_wordpress_aiclientdependencies_nyholm_psr7_factory_psr17factory()
			return Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy.createclient(mut rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory](var_psr17Factory))
		}
		return rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'class', val: rt.new_closure(closure_1_fn) },
			]) },
		])
	}
	mut var_psr17Factories := rt.create_array([
		rt.ArrayItem{
			key: none
			val: 'WordPress\\AiClientDependencies\\Psr\\Http\\Message\\RequestFactoryInterface'
		},
		rt.ArrayItem{
			key: none
			val: 'WordPress\\AiClientDependencies\\Psr\\Http\\Message\\ResponseFactoryInterface'
		},
		rt.ArrayItem{
			key: none
			val: 'WordPress\\AiClientDependencies\\Psr\\Http\\Message\\ServerRequestFactoryInterface'
		},
		rt.ArrayItem{
			key: none
			val: 'WordPress\\AiClientDependencies\\Psr\\Http\\Message\\StreamFactoryInterface'
		},
		rt.ArrayItem{
			key: none
			val: 'WordPress\\AiClientDependencies\\Psr\\Http\\Message\\UploadedFileFactoryInterface'
		},
		rt.ArrayItem{
			key: none
			val: 'WordPress\\AiClientDependencies\\Psr\\Http\\Message\\UriFactoryInterface'
		},
	])
	if rt.is_true(rt.call_function('in_array', [var_type.dup(),
		var_psr17Factories.dup(), rt.new_bool(true)]))
	{
		return rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory.class()
				},
			]) },
		])
	}
	return rt.new_array()
}

fn Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy.createclient(mut var_psr17Factory Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory) {
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_http_abstracts_abstractclientdiscoverystrategy() &Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy{
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

fn create_wordpress_aiclientdependencies_nyholm_psr7_factory_psr17factory() &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy.init()
			return rt.new_null()
		}
		'getCandidates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy.getcandidates(dispatch_arg_0)
		}
		'createClient' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy.createclient(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Abstracts_AbstractClientDiscoveryStrategy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_php_ai_client_src_providers_http_abstracts_abstractclientdiscoverystrategy_php() {
	// unsupported statement: Stmt_Declare
}
