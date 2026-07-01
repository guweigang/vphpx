import rt

struct Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy {
	rt.PhpObjectBase
pub mut:
		puliFactory rt.PhpVal = rt.new_null()
		puliDiscovery rt.PhpVal = rt.new_null()
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy.getpulifactory() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('PULI_FACTORY_CLASS')]))))) {
			rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException', []string{}, create_wordpress_aiclientdependencies_http_discovery_exception_puliunavailableexception(rt.new_string('Puli Factory is not available'))))
		}
		mut var_puliFactoryClass := rt.get_constant('PULI_FACTORY_CLASS')
		if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery{}; return temp.safeclassexists(arg_0) }(var_puliFactoryClass.dup()))))) {
			rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException', []string{}, create_wordpress_aiclientdependencies_http_discovery_exception_puliunavailableexception(rt.new_string('Puli Factory class does not exist'))))
		}
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy.getpulidiscovery() rt.PhpVal {
	if !(!(// unsupported expression: Expr_StaticPropertyFetch).is_null()) {
		mut var_factory := Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy.getpulifactory()
		mut var_repository := rt.call_method(var_factory, 'createRepository', []rt.PhpVal{})
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy.getcandidates(var_type rt.PhpVal) rt.PhpVal {
	mut var_returnData := rt.new_array()
	mut var_bindings := rt.call_method(Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy.getpulidiscovery(), 'findBindings', [var_type.dup()])
	{
		mut iter_1 := var_bindings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_binding := item_1.val
			mut var_condition := rt.new_bool(rt.new_bool(true))
			if rt.is_true(rt.call_method(var_binding, 'hasParameterValue', [rt.new_string('depends')])) {
				var_condition = rt.call_method(var_binding, 'getParameterValue', [rt.new_string('depends')])
			}
			var_returnData.array_push(rt.create_array([rt.ArrayItem{ key: 'class', val: rt.call_method(var_binding, 'getClassName', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'condition', val: var_condition }]))
		}
	}
	return var_returnData.dup()
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_http_discovery_strategy_pulibetastrategy() &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy{
		PhpObjectBase: rt.PhpObjectBase{}
		puliFactory: rt.new_null()
		puliDiscovery: rt.new_null()
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_exception_puliunavailableexception() &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_classdiscovery() &Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getPuliFactory' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy.getpulifactory()
		}
		'getPuliDiscovery' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy.getpulidiscovery()
		}
		'getCandidates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy.getcandidates(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'puliFactory' { return this.puliFactory }
		'puliDiscovery' { return this.puliDiscovery }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'puliFactory' { this.puliFactory = val; return true }
		'puliDiscovery' { this.puliDiscovery = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn init_registry() {
	rt.register_class_factory('WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wordpress_aiclientdependencies_http_discovery_strategy_pulibetastrategy()
		return rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy', ['DiscoveryStrategy'], obj)
	})
	rt.register_class_factory('WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wordpress_aiclientdependencies_http_discovery_exception_puliunavailableexception()
		return rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException', []string{}, obj)
	})
	rt.register_class_factory('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wordpress_aiclientdependencies_http_discovery_classdiscovery()
		return rt.new_object('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_php_ai_client_third_party_http_discovery_strategy_pulibetastrategy_php() {
}
