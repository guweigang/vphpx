import rt

struct Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy {
	rt.PhpObjectBase
pub mut:
		classes rt.PhpVal = rt.new_array()
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.getcandidates(var_type rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(Class_WordPress_AiClientDependencies_Psr_Http_Client_ClientInterface.class(), var_type)) {
		return Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.getpsr18candidates()
	}
	return if !(// unsupported expression: Expr_StaticPropertyFetch.array_get(var_type)).is_null() { // unsupported expression: Expr_StaticPropertyFetch.array_get(var_type) } else { rt.new_array() }
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.getpsr18candidates() rt.PhpVal {
	mut var_candidates := // unsupported expression: Expr_StaticPropertyFetch.array_get(Class_WordPress_AiClientDependencies_Psr_Http_Client_ClientInterface.class())
	{
		mut iter_1 := // unsupported expression: Expr_StaticPropertyFetch.array_get(Class_WordPress_AiClientDependencies_Http_Client_HttpClient.class()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_c := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_c.array_get('class').is_string()))))) {
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery{}; return temp.safeclassexists(arg_0) }(var_c.array_get('class'))) && rt.is_true(rt.call_function('is_subclass_of', [var_c.array_get('class'), Class_WordPress_AiClientDependencies_Psr_Http_Client_ClientInterface.class()])))) {
				var_candidates.array_push(var_c.dup())
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'WordPress_AiClientDependencies_Http_Discovery_Strategy_Throwable') {
				mut var_e := var_e_1.dup()
				rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('Got exception "%s (%s)" while checking if a PSR-18 Client is available'), rt.call_function('get_class', [var_e.dup()]), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.get_constant('E_USER_WARNING')])
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
		}
	}
	return var_candidates.dup()
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.buzzinstantiate() rt.PhpVal {
	return create_wordpress_aiclientdependencies_http_discovery_strategy_wordpress_aiclientdependencies_buzz_client_filegetcontents(fn () rt.PhpVal { mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}; return temp.findresponsefactory() }())
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.symfonypsr18instantiate() rt.PhpVal {
	return create_wordpress_aiclientdependencies_symfony_component_httpclient_psr18client(rt.new_null(), fn () rt.PhpVal { mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}; return temp.findresponsefactory() }(), fn () rt.PhpVal { mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}; return temp.findstreamfactory() }())
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.isguzzleimplementingpsr18() rt.PhpVal {
	return rt.call_function('defined', [rt.new_string('GuzzleHttp\\ClientInterface::MAJOR_VERSION')])
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.issymfonyimplementinghttpclient() rt.PhpVal {
	return rt.call_function('is_subclass_of', [Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_HttplugClient.class(), Class_WordPress_AiClientDependencies_Http_Client_HttpClient.class()])
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.ispsr17factoryinstalled() bool {
	fn () rt.PhpVal { mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}; return temp.findresponsefactory() }()
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'WordPress_AiClientDependencies_Http_Discovery_Exception_NotFoundException') {
		mut var_e := var_e_2.dup()
		return false
		unsafe { goto end_label_2 }
	}
	else if rt.instance_of(var_e_2, 'WordPress_AiClientDependencies_Http_Discovery_Strategy_Throwable') {
		mut var_e := var_e_2.dup()
		rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('Got exception "%s (%s)" while checking if a PSR-17 ResponseFactory is available'), rt.call_function('get_class', [var_e.dup()]), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.get_constant('E_USER_WARNING')])
		return false
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return true
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Buzz_Client_FileGetContents {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_Psr18Client {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_http_discovery_strategy_commonclassesstrategy() &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy{
		PhpObjectBase: rt.PhpObjectBase{}
		classes: rt.new_array()
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_classdiscovery() &Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_strategy_wordpress_aiclientdependencies_buzz_client_filegetcontents() &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Buzz_Client_FileGetContents {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Buzz_Client_FileGetContents{
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

fn create_wordpress_aiclientdependencies_symfony_component_httpclient_psr18client() &Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_Psr18Client {
	mut obj := &Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_Psr18Client{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getCandidates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.getcandidates(dispatch_arg_0)
		}
		'getPsr18Candidates' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.getpsr18candidates()
		}
		'buzzInstantiate' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.buzzinstantiate()
		}
		'symfonyPsr18Instantiate' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.symfonypsr18instantiate()
		}
		'isGuzzleImplementingPsr18' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.isguzzleimplementingpsr18()
		}
		'isSymfonyImplementingHttpClient' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.issymfonyimplementinghttpclient()
		}
		'isPsr17FactoryInstalled' {
			return rt.new_bool(Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.ispsr17factoryinstalled())
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'classes' { return this.classes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'classes' { this.classes = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Buzz_Client_FileGetContents) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Buzz_Client_FileGetContents) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_WordPress_AiClientDependencies_Buzz_Client_FileGetContents) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_Psr18Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_Psr18Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Symfony_Component_HttpClient_Psr18Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_php_ai_client_third_party_http_discovery_strategy_commonclassesstrategy_php() {
}
