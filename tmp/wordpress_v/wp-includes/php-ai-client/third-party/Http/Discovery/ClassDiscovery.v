import rt

struct Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery {
	rt.PhpObjectBase
pub mut:
		strategies rt.PhpVal = rt.new_array()
		deprecatedStrategies rt.PhpVal = rt.new_array()
		cache rt.PhpVal = rt.new_array()
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.findonebytype(var_type rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_class.dup()
	}
	// unsupported statement: Stmt_Static
	if !(var_skipStrategy).is_null() { var_skipStrategy } else { mut var_skipStrategy := if rt.is_true(Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.safeclassexists(Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_GeneratedDiscoveryStrategy.class())) { rt.new_bool(false) } else { Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_GeneratedDiscoveryStrategy.class() } }
	mut var_exceptions := rt.new_array()
	{
		mut iter_1 := // unsupported expression: Expr_StaticPropertyFetch.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_strategy := item_1.val
			if rt.is_true(rt.identical(var_skipStrategy, var_strategy)) {
				continue
			}
			mut var_candidates := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_{"nodeType":"Expr_Variable","line":55,"name":"strategy"}{}; return temp.getcandidates(arg_0) }(var_type.dup())
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'WordPress_AiClientDependencies_Http_Discovery_Exception_StrategyUnavailableException') {
				mut var_e := var_e_1.dup()
				if !(// unsupported expression: Expr_StaticPropertyFetch.array_isset(var_strategy)) {
					var_exceptions.array_push(var_e.dup())
				}
				continue
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
			{
				mut iter_2 := var_candidates.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_candidate := item_2.val
					if var_candidate.array_isset(rt.new_string('condition')) {
						if rt.is_true(rt.new_bool(!(rt.is_true(Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.evaluatecondition(var_candidate.array_get('condition')))))) {
							continue
						}
					}
					Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.storeincache(var_type.dup(), var_candidate.dup())
					return var_candidate.array_get('class')
				}
			}
			var_exceptions.array_push(create_wordpress_aiclientdependencies_http_discovery_exception_nocandidatefoundexception(var_strategy.dup(), var_candidates.dup()))
		}
	}
	rt.throw_exception(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException{}; return temp.create(arg_0) }(var_exceptions.dup()))
	return rt.new_null()
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.getfromcache(var_type rt.PhpVal) rt.PhpVal {
	if !(// unsupported expression: Expr_StaticPropertyFetch.array_isset(var_type)) {
		return rt.new_null()
	}
	mut var_candidate := // unsupported expression: Expr_StaticPropertyFetch.array_get(var_type)
	if var_candidate.array_isset(rt.new_string('condition')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.evaluatecondition(var_candidate.array_get('condition')))))) {
			return rt.new_null()
		}
	}
	return var_candidate.array_get('class')
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.storeincache(var_type rt.PhpVal, var_class rt.PhpVal)  {
	// unsupported expression: Expr_StaticPropertyFetch.array_set(var_type, var_class.dup())
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.setstrategies(mut var_strategies Class_WordPress_AiClientDependencies_Http_Discovery_array)  {
	// unsupported assign target: Expr_StaticPropertyFetch
	Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.clearcache()
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.getstrategies() rt.PhpVal {
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.appendstrategy(var_strategy rt.PhpVal)  {
	// unsupported expression: Expr_StaticPropertyFetch.array_push(var_strategy.dup())
	Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.clearcache()
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.prependstrategy(var_strategy rt.PhpVal)  {
	rt.call_function('array_unshift', [// unsupported expression: Expr_StaticPropertyFetch, var_strategy.dup()])
	Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.clearcache()
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.clearcache()  {
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.evaluatecondition(var_condition rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(var_condition.dup().is_string())) {
		return (Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.safeclassexists(var_condition.dup())).to_bool()
	}
	if rt.is_true(rt.call_function('is_callable', [var_condition.dup()])) {
		return (// unsupported expression: Expr_Cast_Bool).to_bool()
	}
	if rt.is_true(rt.new_bool(var_condition.dup().is_bool())) {
		return (var_condition).to_bool()
	}
	if rt.is_true(rt.new_bool(var_condition.dup().is_array())) {
		{
			mut iter_1 := var_condition.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_c := item_1.val
				if rt.is_true(rt.identical(rt.new_bool(false), Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.evaluatecondition(var_c.dup()))) {
					return false
				}
			}
		}
		return true
	}
	return false
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery.instantiateclass(var_class rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_class.dup().is_string())) {
		return rt.create_object_dynamically(var_class, []rt.PhpVal{})
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.call_function('is_callable', [var_class.dup()])) {
		return rt.call_callable(var_class, []rt.PhpVal{})
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'WordPress_AiClientDependencies_Http_Discovery_Exception') {
		mut var_e := var_e_2.dup()
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Http_Discovery_Exception_ClassInstantiationFailedException', []string{}, create_wordpress_aiclientdependencies_http_discovery_exception_classinstantiationfailedexception(rt.new_string('Unexpected exception when instantiating class.'), rt.new_int(0), var_e.dup())))
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
	return rt.is_true(rt.call_function('class_exists', [var_class.dup()])) || rt.is_true(rt.call_function('interface_exists', [var_class.dup()]))
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'WordPress_AiClientDependencies_Http_Discovery_Exception') {
		mut var_e := var_e_3.dup()
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

fn create_wordpress_aiclientdependencies_http_discovery_classdiscovery() &Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery{
		PhpObjectBase: rt.PhpObjectBase{}
		strategies: rt.new_array()
		deprecatedStrategies: rt.new_array()
		cache: rt.new_array()
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_{"nodetype":"expr_variable","line":55,"name":"strategy"}() &Class_WordPress_AiClientDependencies_Http_Discovery_{"nodeType":"Expr_Variable","line":55,"name":"strategy"} {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_{"nodeType":"Expr_Variable","line":55,"name":"strategy"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_exception_nocandidatefoundexception() &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_NoCandidateFoundException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_exception_discoveryfailedexception() &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_DiscoveryFailedException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_exception_classinstantiationfailedexception() &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_ClassInstantiationFailedException {
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
	match prop_name {
		'strategies' { return this.strategies }
		'deprecatedStrategies' { return this.deprecatedStrategies }
		'cache' { return this.cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_ClassDiscovery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'strategies' { this.strategies = val; return true }
		'deprecatedStrategies' { this.deprecatedStrategies = val; return true }
		'cache' { this.cache = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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



pub fn init_wp_includes_php_ai_client_third_party_http_discovery_classdiscovery_php() {
}
