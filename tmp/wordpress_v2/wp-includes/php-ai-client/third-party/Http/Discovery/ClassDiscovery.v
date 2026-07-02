import rt

struct Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery {
	rt.PhpObjectBase
}

fn init_static_wordpress_aiclientdependencies_http_discovery_classdiscovery() {
		rt.init_static_prop('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery', 'strategies', rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_GeneratedDiscoveryStrategy.class() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonClassesStrategy.class() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonPsr17ClassesStrategy.class() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy.class() }]))
		rt.init_static_prop('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery', 'deprecatedStrategies', rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_PuliBetaStrategy.class(), val: true }]))
		rt.init_static_prop('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery', 'cache', rt.new_array())
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.findonebytype(var_type rt.PhpVal) rt.PhpVal {
	mut var_class := Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.getfromcache(var_type.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_class)))) {
		return var_class.clone()
	}
	mut var_skipStrategy := rt.new_null()
	var_skipStrategy = if rt.is_true(Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.safeclassexists(Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_GeneratedDiscoveryStrategy.class())) { rt.new_bool(false) } else { Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_GeneratedDiscoveryStrategy.class() }
	if !(var_skipStrategy).is_null() { var_skipStrategy } else { var_skipStrategy }
	mut var_exceptions := rt.new_array()
	mut iter_1 := rt.get_static_prop('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery', 'strategies').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_strategy := item_1.val
		if rt.is_true(rt.identical(var_skipStrategy, var_strategy)) {
			continue
		}
		mut iife_temp_0 := Class_WordPress_AiClientDependencies_Http_Discovery_{"nodeType":"Expr_Variable","line":55,"name":"strategy"}{}
		mut iife_result_0 := iife_temp_0.getcandidates(var_type.clone())
		mut var_candidates := iife_result_0
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'WordPress_AiClientDependencies_Http_Discovery_Exception_StrategyUnavailableException') {
			mut var_e := var_e_1.clone()
			if !(rt.get_static_prop('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery', 'deprecatedStrategies').array_isset(var_strategy)) {
				var_exceptions.array_push(var_e.clone())
			}
			continue
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
		mut iter_2 := var_candidates.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_candidate := item_2.val
			if var_candidate.array_isset(rt.new_string('condition')) {
				if rt.is_true(rt.new_bool(!(rt.is_true(Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.evaluatecondition(var_candidate.array_get(rt.new_string('condition'))))))) {
					continue
				}
			}
			Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.storeincache(var_type.clone(), var_candidate.clone())
			return var_candidate.array_get(rt.new_string('class'))
		}
		var_exceptions.array_push(create_wordpress_aiclientdependencies_http_discovery_exception_nocandidatefoundexception(var_strategy.clone(), var_candidates.clone()))
	}
	mut iife_temp_1 := Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException{}
	mut iife_result_1 := iife_temp_1.create(var_exceptions.clone())
	rt.throw_exception(iife_result_1)
	return rt.new_null()
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.getfromcache(var_type rt.PhpVal) rt.PhpVal {
	if !(rt.get_static_prop('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery', 'cache').array_isset(var_type)) {
		return rt.new_null()
	}
	mut var_candidate := rt.get_static_prop('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery', 'cache').array_get(var_type)
	if var_candidate.array_isset(rt.new_string('condition')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.evaluatecondition(var_candidate.array_get(rt.new_string('condition'))))))) {
			return rt.new_null()
		}
	}
	return var_candidate.array_get(rt.new_string('class'))
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.storeincache(var_type rt.PhpVal, var_class rt.PhpVal) {
	rt.get_static_prop('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery', 'cache').array_set(var_type, var_class.clone())
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.setstrategies(mut var_strategies Class_WordPress_AiClientDependencies_Http_Discovery_array) {
	rt.set_static_prop('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery', 'strategies', var_strategies)
	Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.clearcache()
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.getstrategies() rt.PhpVal {
	return rt.get_static_prop('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery', 'strategies')
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.appendstrategy(var_strategy rt.PhpVal) {
	rt.get_static_prop('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery', 'strategies').array_push(var_strategy.clone())
	Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.clearcache()
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.prependstrategy(var_strategy rt.PhpVal) {
	rt.call_function('array_unshift', [rt.get_static_prop('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery', 'strategies'), var_strategy.clone()])
	Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.clearcache()
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.clearcache() {
	rt.set_static_prop('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery', 'cache', rt.new_array())
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.evaluatecondition(var_condition rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(var_condition.clone().is_string())) {
		return (Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.safeclassexists(var_condition.clone())).to_bool()
	}
	if rt.is_true(rt.call_function('is_callable', [var_condition.clone()])) {
		return (rt.call_callable(var_condition, []rt.PhpVal{})).to_bool()
	}
	if rt.is_true(rt.new_bool(var_condition.clone().is_bool())) {
		return (var_condition).to_bool()
	}
	if rt.is_true(rt.new_bool(var_condition.clone().is_array())) {
		mut iter_3 := var_condition.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_c := item_3.val
			if rt.is_true(rt.identical(rt.new_bool(false), Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.evaluatecondition(var_c.clone()))) {
				return false
			}
		}
		return true
	}
	return false
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.instantiateclass(var_class rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_class.clone().is_string())) {
		return rt.new_object('', []string{}, rt.create_object_dynamically(var_class, []rt.PhpVal{}))
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.call_function('is_callable', [var_class.clone()])) {
		return rt.call_callable(var_class, []rt.PhpVal{})
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'WordPress_AiClientDependencies_Http_Discovery_Exception') {
		mut var_e := var_e_2.clone()
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception_ClassInstantiationFailedException', []string{}, create_wordpress_aiclientdependencies_http_discovery_exception_classinstantiationfailedexception(rt.new_string('Unexpected exception when instantiating class.'), rt.new_int(0), var_e.clone())))
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception_ClassInstantiationFailedException', []string{}, create_wordpress_aiclientdependencies_http_discovery_exception_classinstantiationfailedexception(rt.new_string('Could not instantiate class because parameter is neither a callable nor a string'))))
	return rt.new_null()
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.safeclassexists(var_class rt.PhpVal) bool {
	return rt.is_true(rt.call_function('class_exists', [var_class.clone()])) || rt.is_true(rt.call_function('interface_exists', [var_class.clone()]))
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'WordPress_AiClientDependencies_Http_Discovery_Exception') {
		mut var_e := var_e_3.clone()
		return false
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	return false
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_{"nodeType":"Expr_Variable","line":55,"name":"strategy"} {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Exception_ClassInstantiationFailedException {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_http_discovery_classdiscovery(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_{"nodetype":"expr_variable","line":55,"name":"strategy"}(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_{"nodeType":"Expr_Variable","line":55,"name":"strategy"} {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_{"nodeType":"Expr_Variable","line":55,"name":"strategy"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_exception_nocandidatefoundexception(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_exception_discoveryfailedexception(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_exception_classinstantiationfailedexception(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_ClassInstantiationFailedException {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_ClassInstantiationFailedException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'findOneByType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.findonebytype(dispatch_arg_0)
		}
		'getFromCache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.getfromcache(dispatch_arg_0)
		}
		'storeInCache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.storeincache(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'setStrategies' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Http_Discovery_array](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.setstrategies(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getStrategies' {
			return Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.getstrategies()
		}
		'appendStrategy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.appendstrategy(dispatch_arg_0)
			return rt.new_null()
		}
		'prependStrategy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.prependstrategy(dispatch_arg_0)
			return rt.new_null()
		}
		'clearCache' {
			Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.clearcache()
			return rt.new_null()
		}
		'evaluateCondition' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.evaluatecondition(dispatch_arg_0))
		}
		'instantiateClass' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.instantiateclass(dispatch_arg_0)
		}
		'safeClassExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.safeclassexists(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_{"nodeType":"Expr_Variable","line":55,"name":"strategy"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_{"nodeType":"Expr_Variable","line":55,"name":"strategy"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_{"nodeType":"Expr_Variable","line":55,"name":"strategy"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_ClassInstantiationFailedException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_ClassInstantiationFailedException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_ClassInstantiationFailedException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wordpress_aiclientdependencies_http_discovery_classdiscovery()
		return rt.new_object('WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery', []string{}, obj)
	})
	rt.register_class_factory('WordPress_AiClientDependencies_Http_Discovery_{"nodeType":"Expr_Variable","line":55,"name":"strategy"}', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wordpress_aiclientdependencies_http_discovery_{"nodetype":"expr_variable","line":55,"name":"strategy"}()
		return rt.new_object('WordPress_AiClientDependencies_Http_Discovery_{"nodeType":"Expr_Variable","line":55,"name":"strategy"}', []string{}, obj)
	})
	rt.register_class_factory('WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wordpress_aiclientdependencies_http_discovery_exception_nocandidatefoundexception()
		return rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException', []string{}, obj)
	})
	rt.register_class_factory('WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wordpress_aiclientdependencies_http_discovery_exception_discoveryfailedexception()
		return rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException', []string{}, obj)
	})
	rt.register_class_factory('WordPress_AiClientDependencies_Http_Discovery_Exception_ClassInstantiationFailedException', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wordpress_aiclientdependencies_http_discovery_exception_classinstantiationfailedexception()
		return rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception_ClassInstantiationFailedException', []string{}, obj)
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
