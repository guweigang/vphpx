import rt

struct Class_WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Exception_StrategyUnavailableException {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_http_discovery_exception_puliunavailableexception(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_PuliUnavailableException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_exception_strategyunavailableexception(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_StrategyUnavailableException {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_StrategyUnavailableException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_StrategyUnavailableException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_StrategyUnavailableException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_StrategyUnavailableException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
