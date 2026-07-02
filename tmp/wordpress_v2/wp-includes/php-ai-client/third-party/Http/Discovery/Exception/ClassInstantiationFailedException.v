import rt

struct Class_WordPress_AiClientDependencies_Http_Discovery_Exception_ClassInstantiationFailedException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Exception_RuntimeException {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_http_discovery_exception_classinstantiationfailedexception(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_ClassInstantiationFailedException {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_ClassInstantiationFailedException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_exception_runtimeexception(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_RuntimeException {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Exception_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Exception_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
