import rt

struct Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy {
	rt.PhpObjectBase
}

fn init_static_wordpress_aiclientdependencies_http_discovery_strategy_pulibetastrategy() {
	rt.init_static_prop('WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy',
		'puliFactory', rt.new_null())
	rt.init_static_prop('WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy',
		'puliDiscovery', rt.new_null())
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy.getpulifactory() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy',
		'puliFactory')))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
			rt.new_string('PULI_FACTORY_CLASS'),
		])))))
		{
			rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException',
				[]string{},
				create_wordpress_aiclientdependencies_http_discovery_exception_puliunavailableexception(rt.new_string('Puli Factory is not available'))))
		}
		mut var_puliFactoryClass := rt.get_constant('PULI_FACTORY_CLASS')
		mut iife_temp_0 := Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery{}
		mut iife_result_0 := iife_temp_0.safeclassexists(var_puliFactoryClass.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
			rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException',
				[]string{},
				create_wordpress_aiclientdependencies_http_discovery_exception_puliunavailableexception(rt.new_string('Puli Factory class does not exist'))))
		}
		rt.set_static_prop('WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy',
			'puliFactory', rt.new_object('', []string{}, rt.create_object_dynamically(var_puliFactoryClass,
			[]rt.PhpVal{})))
	}
	return rt.get_static_prop('WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy',
		'puliFactory')
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy.getpulidiscovery() rt.PhpVal {
	if !(!(rt.get_static_prop('WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy',
		'puliDiscovery')).is_null()) {
		mut var_factory :=
			Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy.getpulifactory()
		mut var_repository := rt.call_method(var_factory, 'createRepository', []rt.PhpVal{})
		rt.set_static_prop('WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy',
			'puliDiscovery', rt.call_method(var_factory, 'createDiscovery', [
			var_repository.clone()]))
	}
	return rt.get_static_prop('WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy',
		'puliDiscovery')
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy.getcandidates(var_type rt.PhpVal) rt.PhpVal {
	mut var_returnData := rt.new_array()
	mut var_bindings := rt.call_method(Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy.getpulidiscovery(),
		'findBindings', [var_type.clone()])
	mut iter_1 := var_bindings.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_binding := item_1.val
		mut var_condition := rt.new_bool(true)
		if rt.is_true(rt.call_method(var_binding, 'hasParameterValue', [
			rt.new_string('depends'),
		]))
		{
			var_condition = rt.call_method(var_binding, 'getParameterValue', [
				rt.new_string('depends'),
			])
		}
		var_returnData.array_push(rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_method(var_binding, 'getClassName',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'condition', val: var_condition },
		]))
	}
	return var_returnData.clone()
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_http_discovery_strategy_pulibetastrategy(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_exception_puliunavailableexception(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_classdiscovery(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery {
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
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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
	rt.register_class_factory('WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wordpress_aiclientdependencies_http_discovery_strategy_pulibetastrategy()
		return rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy', [
			'DiscoveryStrategy',
		], obj)
	})
	rt.register_class_factory('WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException', fn (args []rt.PhpVal) rt.PhpVal {
		obj :=
			create_wordpress_aiclientdependencies_http_discovery_exception_puliunavailableexception()
		return rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException',
			[]string{}, obj)
	})
	rt.register_class_factory('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wordpress_aiclientdependencies_http_discovery_classdiscovery()
		return rt.new_object('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery',
			[]string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
